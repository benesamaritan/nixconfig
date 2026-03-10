{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    logseq
    trilium-desktop
  ];
}
