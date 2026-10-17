{
  config,
  lib,
  ...
}:

{
  targets.genericLinux = {
    enable = true;
    gpu.enable = true;
  };
}
