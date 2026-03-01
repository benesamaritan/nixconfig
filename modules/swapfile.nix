{ config, ... }:

{
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  boot.resumeDevice = "/dev/disk/by-uuid/e04a6c4c-63e9-4a0b-a07a-2a166746eb21";

  boot.kernelParams = [
    "resume=true"
    "resume_offset=72458240"
  ];
}
