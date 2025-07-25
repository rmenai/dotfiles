{
  microvm = {
    hypervisor = "qemu";
    vcpu = 4;
    mem = 8 * 1024;

    interfaces = [{
      type = "user";
      id = "vm-qemu";
      mac = "02:00:00:00:00:01";
    }];
  };
}
