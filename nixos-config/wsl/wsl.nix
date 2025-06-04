{
  config,
  pkgs,
  ...
}: {
  imports = [
    <nixos-wsl/modules>
  ];
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  fonts.packages = with pkgs; [
    fira-code
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        lsp = {
          enable = true;
          lspkind.enable = true;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = true;
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
          formatOnSave = true;
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        languages = {
          enableFormat = true;
          enableExtraDiagnostics = true;
          enableTreesitter = true;
          nix.enable = true;
          ts.enable = true;
          css.enable = true;
          csharp.enable = true;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };
        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = false;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    git
    btop
    tmux
    git-credential-oauth
  ];
}
