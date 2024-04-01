return {
  {
    'github/copilot.vim',
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
