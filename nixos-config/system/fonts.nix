{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  fonts = {
    enableDefaultFonts = true;
    enableGhostscriptFonts = true;
    fontconfig.defaultFonts = {
      serif = ["Noto Serif"];
      sansSerif = ["Noto Sans"];
      monospace = ["JetBrainsMono Nerd Font"];
    };
  };
}
