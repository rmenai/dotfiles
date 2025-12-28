{
  microvm = {
    hypervisor = "qemu";

    interfaces = [
      {
        type = "user";
        id = "vm-qemu";
        mac = "02:00:00:00:00:01";
      }
    ];
  };
}
