-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use({'tpope/vim-eunuch', config = function ()
        vim.cmd('cnoreabbrev rename Rename')
    end})
    use({
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require("catppuccin").setup({
                flavour = "latte", -- latte, frappe, macchiato, mocha
                background = {     -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = true, -- disables setting the background color.
                show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
                term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
                dim_inactive = {
                    enabled = false,           -- dims the background color of inactive window
                    shade = "dark",
                    percentage = 0.15,         -- percentage of the shade to apply to the inactive window
                },
                no_italic = false,             -- Force no italic
                no_bold = false,               -- Force no bold
                no_underline = false,          -- Force no underline
                styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { "italic" },   -- Change the style of comments
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                    -- miscs = {}, -- Uncomment to turn off hard-coded styles
                },
                color_overrides = {},
                custom_highlights = {},
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = false,
                    mini = {
                        enabled = true,
                        indentscope_color = "",
                    },
                },
            })
        end,
    })
    use({
        'eliseshaffer/darklight.nvim',
        as = 'darklight',
        config = function()
            require('darklight').setup(
                {
                    mode = 'custom',
                    light_mode_callback = function()
                        print('pizda')
                        local color = "catppuccin-latte"
                        vim.cmd.colorscheme(color)
                        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                    end,

                    dark_mode_callback =
                        function()
                            local color = "catppuccin-mocha"
                            vim.cmd.colorscheme(color)
                            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                        end

                })
        end
    })


    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }
end)
