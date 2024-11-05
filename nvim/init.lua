# Configure lazy plugin manager
require("config.lazy")

require("catppuccin").setup({
    background = {
        light = "latte",
        dark = "macchiato",
    }
  }
)

require('lualine').setup({
  foptions = {
    theme = "catppuccin"
  }
})

vim.cmd.colorscheme "catppuccin"

-- Disable Perl and Ruby syntax highlighting
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Set Python3 interpreter path
vim.g.python3_host_prog = '~/.local/share/virtualenvs/neovim/bin/python'

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- Telescope
local builtin=require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- nvim-treesitter
require("nvim-treesitter")

local wk = require("which-key")
wk.add({
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
})

-- Tab stops
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
