return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
  },
  {
    'github/copilot.vim',
    config = function()
      -- Disable copilot on startup
      vim.cmd(":Copilot disable")
      vim.api.nvim_set_keymap('n', '<leader>co', '<cmd>Copilot<CR>',
        {
          desc = '[c][o]pilot',
          noremap = true,
          silent = true
        })
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {}
      vim.api.nvim_set_keymap('n', '<leader>nt', '<cmd>NvimTreeToggle<CR>',
        {
          desc = 'NvimTree: Toggle',
          noremap = true,
          silent = true
        })
    end,
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('harpoon').setup {}
      vim.api.nvim_set_keymap('n', '<leader>hh', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
        {
          desc = '[h]arpoon: Toggle Quick Menu',
          noremap = true,
          silent = true
        })

      vim.api.nvim_set_keymap('n', '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<CR>',
        {
          desc = 'Harpoon: [a]dd file',
          noremap = true,
          silent = true
        })

      vim.api.nvim_set_keymap('n', '<leader>h1', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>',
        {
          desc = 'Harpoon: [1] nav file',
          noremap = true,
          silent = true
        })
      vim.api.nvim_set_keymap('n', '<leader>h2', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>',
        {
          desc = 'Harpoon: [2] nav file',
          noremap = true,
          silent = true
        })
      vim.api.nvim_set_keymap('n', '<leader>h3', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>',
        {
          desc = 'Harpoon: [3] nav file',
          noremap = true,
          silent = true
        })
      vim.api.nvim_set_keymap('n', '<leader>h4', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>',
        {
          desc = 'Harpoon: [4] nav file',
          noremap = true,
          silent = true
        })

      vim.api.nvim_set_keymap('n', '<leader>h<CR>', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>',
        {
          desc = 'Harpoon: First file',
          noremap = true,
          silent = true
        })

      vim.api.nvim_set_keymap('n', '<leader>ht', '<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>',
        {
          desc = 'Harpoon: [t]erminal',
          noremap = true,
          silent = true
        })
    end,
  },
}
