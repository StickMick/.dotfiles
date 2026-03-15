{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };
}
