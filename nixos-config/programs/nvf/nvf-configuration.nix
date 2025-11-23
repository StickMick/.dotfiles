{
  config,
  pkgs,
  ...
}: {
      vim = {
        options = {
          shada = "'100,<50,s10,h";  # safe default enabling shada with common parameters
        };

        theme = {
          enable = true;
          name = "onedark";
          style = "dark";
        };

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        binds = {
          whichKey = {
            enable = true;
          };
          cheatsheet = {
            enable = true;
          };
          hardtime-nvim = {
            enable = true;
          };
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = true;
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        spellcheck = {
          enable = true;
        };

        lsp = {
          enable = true;
          lspkind.enable = true;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = false; # conflicts with blink
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
          formatOnSave = true;
        };

        telescope.enable = true;

        languages = {
          enableFormat = true;
          enableExtraDiagnostics = true;
          enableTreesitter = true;
          nix.enable = true;
          ts.enable = true;
          css.enable = true;
          csharp.enable = true;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete = {
          blink-cmp.enable = true;
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

        statusline = {
          lualine = {
            enable = true;
            theme = "onedark";
          };
        };

        snippets.luasnip.enable = true;

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        projects = {
          project-nvim.enable = true;
        };

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          yanky-nvim.enable = true;
          icon-picker.enable = true;
          surround.enable = true;
          leetcode-nvim.enable = true;
          multicursors.enable = true;

          motion = {
            hop.enable = true;
            leap.enable = true;
            precognition.enable = true;
          };
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };
  };
}
