use anyhow::{Context, Result};
use arboard::Clipboard;
use clap::Parser;
use serde_json::json;
use std::env;
use std::io::{self, Read};

#[derive(Parser)]
#[command(name = "wastebin")]
#[command(about = "Create pastes from stdin")]
#[command(version = "0.1.0")]
struct Args {
    /// File extension for syntax highlighting
    #[arg(short, long)]
    extension: Option<String>,

    /// Title for the paste
    #[arg(short, long)]
    title: Option<String>,

    /// Expiration time in seconds from now
    #[arg(long, default_value_t = 60 * 24 * 7)]
    expires: u64,

    /// Burn after reading (delete after first view)
    #[arg(short, long)]
    burn: bool,

    /// Password protect the paste
    #[arg(short, long)]
    password: Option<String>,

    /// Base URL for wastebin instance (overrides WASTEBIN_URL env var)
    #[arg(long)]
    url: Option<String>,

    /// Don't copy to clipboard
    #[arg(long)]
    no_clipboard: bool,
}

fn copy_to_clipboard(text: &str) -> Result<()> {
    if let Ok(mut child) = std::process::Command::new("wl-copy")
        .stdin(std::process::Stdio::piped())
        .spawn()
    {
        if let Some(stdin) = child.stdin.as_mut() {
            use std::io::Write;
            if stdin.write_all(text.as_bytes()).is_ok() {
                drop(stdin);
                if child.wait().is_ok() {
                    return Ok(());
                }
            }
        }
    }

    let mut clipboard = Clipboard::new().context("Failed to initialize clipboard")?;
    clipboard
        .set_text(text)
        .context("Failed to set clipboard text")?;
    Ok(())
}

#[tokio::main]
async fn main() -> Result<()> {
    let args = Args::parse();

    // Determine base URL
    let base_url = args
        .url
        .or_else(|| env::var("WASTEBIN_URL").ok())
        .unwrap_or_else(|| "https://bin.menai.me".to_string());

    // Read from stdin
    let mut buffer = String::new();
    io::stdin()
        .read_to_string(&mut buffer)
        .context("Failed to read from stdin")?;

    if buffer.is_empty() {
        anyhow::bail!("No input provided via stdin");
    }

    // Build JSON payload
    let mut payload = json!({
        "text": buffer
    });

    if let Some(ext) = &args.extension {
        payload["extension"] = json!(ext);
    }

    if let Some(title) = &args.title {
        payload["title"] = json!(title);
    }

    payload["expires"] = json!(args.expires);

    if args.burn {
        payload["burn_after_reading"] = json!(true);
    }

    if let Some(password) = &args.password {
        payload["password"] = json!(password);
    }

    // Make POST request
    let client = reqwest::Client::new();
    let response = client
        .post(&base_url)
        .json(&payload)
        .send()
        .await
        .context("Failed to send request to wastebin")?;

    if !response.status().is_success() {
        let status = response.status();
        let body = response.text().await.unwrap_or_default();
        anyhow::bail!("Server returned status {}: {}", status, body);
    }

    let response_json: serde_json::Value = response
        .json()
        .await
        .context("Failed to parse response JSON")?;

    let path = response_json["path"]
        .as_str()
        .context("Response missing 'path' field")?;

    let full_url = format!("{}{}", base_url, path);

    // Copy to clipboard unless disabled
    if !args.no_clipboard {
        match copy_to_clipboard(&full_url) {
            Ok(()) => {
                println!("✓ Paste created and copied to clipboard:");
                println!("{}", full_url);
            }
            Err(e) => {
                println!("✓ Paste created:");
                println!("{}", full_url);
                eprintln!("⚠ Failed to copy to clipboard: {}", e);
            }
        }
    } else {
        println!("✓ Paste created:");
        println!("{}", full_url);
    }

    Ok(())
}
