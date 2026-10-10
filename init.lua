require("config.options")
require("config.float-borders")
require("config.keymaps")
-- require("config.lsp")
require("config.lazy")
require("config.autocmd")
vim.cmd("colorscheme rose-pine")
if vim.fn.filereadable("/home/nuznhy/.config/nvim/quickshell-theme.lua") == 1 then dofile("/home/nuznhy/.config/nvim/quickshell-theme.lua") end -- quickshell-nvim-colors
