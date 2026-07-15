{
  config,
  pkgs,
  inputs,
  ...
}: let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    config = {
      allowUnfree = true;
    };
  };
in {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #dynamic linking through nix-ld
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
        pkgs.SDL
        pkgs.SDL2
        pkgs.SDL2_image
        pkgs.SDL2_mixer
        pkgs.SDL2_ttf
        pkgs.SDL_image
        pkgs.SDL_mixer
        pkgs.SDL_ttf
        pkgs.alsa-lib
        pkgs.at-spi2-atk
        pkgs.at-spi2-core
        pkgs.atk
        pkgs.bzip2
        pkgs.cairo
        pkgs.cups
        pkgs.curlWithGnuTls
        pkgs.dbus
        pkgs.dbus-glib
        pkgs.desktop-file-utils
        pkgs.e2fsprogs
        pkgs.expat
        pkgs.flac
        pkgs.fontconfig
        pkgs.freeglut
        pkgs.freetype
        pkgs.fribidi
        pkgs.fuse
        pkgs.fuse3
        pkgs.gdk-pixbuf
        pkgs.glew110
        pkgs.glib
        pkgs.glibc
        pkgs.gmp
        pkgs.gst_all_1.gst-plugins-base
        pkgs.gst_all_1.gst-plugins-ugly
        pkgs.gst_all_1.gstreamer
        pkgs.gtk2
        pkgs.harfbuzz
        pkgs.icu
        pkgs.keyutils.lib
        pkgs.libGL
        pkgs.libGLU
        pkgs.libappindicator-gtk2
        pkgs.libcaca
        pkgs.libcanberra
        pkgs.libcap
        pkgs.libclang.lib
        pkgs.libdbusmenu
        pkgs.libdrm
        pkgs.libgcc
        pkgs.libgcrypt
        pkgs.libgpg-error
        pkgs.libidn
        pkgs.libjack2
        pkgs.libjpeg
        pkgs.libmikmod
        pkgs.libogg
        pkgs.libpng12
        pkgs.libpulseaudio
        pkgs.librsvg
        pkgs.libsamplerate
        pkgs.libthai
        pkgs.libtheora
        pkgs.libtiff
        pkgs.libudev0-shim
        pkgs.libusb1
        pkgs.libuuid
        pkgs.libvdpau
        pkgs.libvorbis
        pkgs.libvpx
        pkgs.libxcrypt-legacy
        pkgs.libxkbcommon
        pkgs.libxml2
        pkgs.mesa
        pkgs.nspr
        pkgs.nss
        pkgs.openssl
        pkgs.p11-kit
        pkgs.pango
        pkgs.pixman
        pkgs.python3
        pkgs.speex
        pkgs.stdenv.cc.cc
        pkgs.stdenv.cc.cc.lib
        pkgs.systemd
        pkgs.tbb
        pkgs.udev
        pkgs.util-linux
        pkgs.vulkan-loader
        pkgs.wayland
        pkgs.xorg.libICE
        pkgs.xorg.libSM
        pkgs.xorg.libX11
        pkgs.xorg.libXScrnSaver
        pkgs.xorg.libXcomposite
        pkgs.xorg.libXcursor
        pkgs.xorg.libXdamage
        pkgs.xorg.libXext
        pkgs.xorg.libXfixes
        pkgs.xorg.libXft
        pkgs.xorg.libXi
        pkgs.xorg.libXinerama
        pkgs.xorg.libXmu
        pkgs.xorg.libXrandr
        pkgs.xorg.libXrender
        pkgs.xorg.libXt
        pkgs.xorg.libXtst
        pkgs.xorg.libXxf86vm
        pkgs.xorg.libpciaccess
        pkgs.xorg.libxcb
        pkgs.xorg.xcbutil
        pkgs.xorg.xcbutilimage
        pkgs.xorg.xcbutilkeysyms
        pkgs.xorg.xcbutilrenderutil
        pkgs.xorg.xcbutilwm
        pkgs.xorg.xkeyboardconfig
        pkgs.xz
        pkgs.zlib
      ];
  };

  environment.systemPackages = with pkgs; [
    git
    gh
    zig
    vscode
    xclip
    ripgrep
    gnumake
    wget
    fd
    git-credential-oauth
    lazygit
    android-studio
    gcc
    wezterm

    nodejs
    tree-sitter

    unityhub

    neovim

    jetbrains-toolbox

    pkgs-unstable.dotnet-sdk_11
  ];
}
