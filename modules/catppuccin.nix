{
  inputs,
  ...
}:

{
  imports = [ inputs.catppuccin.nixosModules.catppuccin ];
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "pink";
    cache.enable = true;
    cursors.enable = true;
  };
}
