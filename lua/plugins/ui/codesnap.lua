-- ~/.config/nvim/lua/plugins/codesnap.lua
--

return {
    "mistricky/codesnap.nvim",
    tag = "v2.0.5",

    keys = {
        {
            "<leader>cs",
            ":CodeSnap<CR>",
            mode = "x",
            desc = "Copy code snapshot",
        },
        {
            "<leader>cS",
            ":CodeSnapSave ~/Pictures/codesnap.png<CR>",
            mode = "x",
            desc = "Save code snapshot",
        },
    },

    opts = {
        show_line_number = true,
        show_workspace = true,
        snapshot_config = {
            theme = "candy",
            background = "#191724",
            window = {
                mac_window_bar = false,
            },
            watermark = {
                content = "",
                font_family = "Pacifico",
                color = "#ffffff",
            },
        },
        code_config = {
            breadcrumbs = {
                enable = true,
                separator = "/",
                color = "#80848b",
                font_family = "CaskaydiaCove Nerd Font",
            },
        }
    }
}
