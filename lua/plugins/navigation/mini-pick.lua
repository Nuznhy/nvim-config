return {
    'nvim-mini/mini.pick',
    version = '*',
    cmd = 'Pick',
    dependencies = { 'nvim-mini/mini.extra' },
    keys = {
        {
            '<leader>f',
            function() require('mini.pick').builtin.files({}, { source = { name = 'Files | Shift+Tab: shortcuts' } }) end,
            desc = 'Find files',
        },
        {
            '<leader>sf',
            function()
                require('mini.pick').builtin.cli({
                    command = { 'rg', '--files', '--hidden', '--glob', '!.git', '--color=never' },
                }, { source = { name = 'Files (hidden included) | Shift+Tab: shortcuts' } })
            end,
            desc = 'Find files including hidden',
        },
        {
            '<leader>sp',
            function() require('mini.pick').builtin.files({ tool = 'git' }, { source = { name = 'Git files | Shift+Tab: shortcuts' } }) end,
            desc = 'Git files',
        },
        {
            '<leader>sg',
            function() require('mini.pick').builtin.grep_live() end,
            desc = 'Live grep',
        },
        {
            '<leader>sr',
            function() require('mini.extra').pickers.lsp({ scope = 'references' }) end,
            desc = 'References',
        },
        {
            '<leader>sd',
            function() require('mini.extra').pickers.diagnostic({ scope = 'current' }) end,
            desc = 'Buffer diagnostics',
        },
        {
            '<leader>sb',
            function() require('mini.pick').builtin.buffers() end,
            desc = 'Buffers',
        },
        {
            '<leader>so',
            function() require('mini.extra').pickers.oldfiles() end,
            desc = 'Recent files',
        },
    },
    config = function()
        require("mini.pick").setup()
        require("mini.extra").setup()

        local function set_selection_highlight()
            -- CursorLine and NormalFloat share a background in the Quickshell theme.
            vim.api.nvim_set_hl(0, 'MiniPickMatchCurrent', { link = 'PmenuSel' })
        end

        vim.api.nvim_create_autocmd('ColorScheme', {
            group = vim.api.nvim_create_augroup('MiniPickSelection', { clear = true }),
            callback = set_selection_highlight,
        })
        set_selection_highlight()
    end,
}
