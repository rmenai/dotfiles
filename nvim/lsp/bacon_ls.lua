return {
  init_options = {
    updateOnSave = true,
    updateOnSaveWaitMillis = 0,
    synchronizeAllOpenFilesWaitMillis = 0,
    runBaconInBackground = true,
  },

  on_attach = function(client, bufnr) vim.diagnostic.config({ update_in_insert = true }) end,
}
