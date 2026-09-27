local function path_breadcrumbs(path)
    return (path:gsub('/', ' › '))
end

local function code_context()
    local navic = require('nvim-navic')
    local location = navic.is_available() and navic.get_location() or ''
    return location ~= '' and location or ''
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = { "alpha" },
                winbar = { "alpha" },
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
                refresh_time = 16, -- ~60fps
                events = {
                    'WinEnter',
                    'BufEnter',
                    'BufWritePost',
                    'SessionLoadPost',
                    'FileChangedShellPost',
                    'VimResized',
                    'Filetype',
                    'CursorMoved',
                    'CursorMovedI',
                    'ModeChanged',
                },
            }
        },
        sections = {
            lualine_a = { 'mode', {
                function()
                    local reg = vim.fn.reg_recording()
                    if reg == "" then return "" end -- not recording
                    return "recording to " .. reg
                end }
            },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
                { 'filename', path = 1, fmt = path_breadcrumbs },
            },
            lualine_x = { 'lsp_status' },
            lualine_y = { 'filetype' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
                { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
                { 'filename', path = 1, fmt = path_breadcrumbs },
            },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        winbar = {
            lualine_c = { code_context },
        },
        inactive_winbar = {
            lualine_c = { code_context },
        },
        tabline = {},
        extensions = {}
    }
}
