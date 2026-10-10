local function apply()
    local float = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    local accent = vim.api.nvim_get_hl(0, { name = "Title", link = false })
    local background = normal.bg or "NONE"

    -- Border glyphs occupy whole terminal cells. Match the editor background
    -- so those cells don't look like padding outside the thin outline.
    vim.api.nvim_set_hl(0, "FloatBorder", {
        fg = accent.fg or float.fg or normal.fg,
        bg = background,
    })
    for _, name in ipairs({
        "NoiceCmdlinePopupBorder",
        "NoiceCmdlinePopupBorderCmdline",
        "NoiceCmdlinePopupBorderSearch",
        "NoiceCmdlinePopupBorderHelp",
        "NoiceCmdlinePopupBorderLua",
        "NoiceCmdlinePopupBorderInput",
        "NoicePopupBorder",
        "NoicePopupmenuBorder",
        "NoiceConfirmBorder",
        "BlinkCmpMenuBorder",
        "BlinkCmpDocBorder",
        "BlinkCmpSignatureHelpBorder",
    }) do
        vim.api.nvim_set_hl(0, name, { link = "FloatBorder" })
    end

    for level, group in pairs({
        ERROR = "DiagnosticError",
        WARN = "DiagnosticWarn",
        INFO = "DiagnosticInfo",
        DEBUG = "Comment",
        TRACE = "DiagnosticHint",
    }) do
        local color = vim.api.nvim_get_hl(0, { name = group, link = false })
        vim.api.nvim_set_hl(0, "Notify" .. level .. "Border", {
            fg = color.fg or accent.fg or normal.fg,
            bg = background,
        })
        vim.api.nvim_set_hl(0, "Notify" .. level .. "Body", { link = "NormalFloat" })
        for _, part in ipairs({ "Title", "Icon" }) do
            vim.api.nvim_set_hl(0, "Notify" .. level .. part, {
                fg = color.fg or accent.fg or normal.fg,
                bg = float.bg or normal.bg or "NONE",
            })
        end
    end
end

-- Keep the outlines when Quickshell or a colorscheme refreshes highlights.
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("FloatBorders", { clear = true }),
    callback = apply,
})
apply()
