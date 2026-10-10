return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            views = {
                cmdline_popup = {
                    border = { style = "rounded" },
                    win_options = {
                        winhighlight = {
                            -- NUI draws this padded border inside another window.
                            -- Match the editor so its background doesn't frame the outline.
                            Normal = "Normal",
                            FloatBorder = "FloatBorder",
                            FloatTitle = "FloatTitle",
                        },
                    },
                },

                popupmenu = {
                    border = { style = "rounded" },
                    win_options = {
                        winhighlight = {
                            Normal = "Pmenu",
                            FloatBorder = "FloatBorder",
                            CursorLine = "PmenuSel",
                        },
                    },
                },

                confirm = {
                    border = { style = "rounded" },
                    win_options = {
                        winhighlight = {
                            Normal = "NormalFloat",
                            FloatBorder = "FloatBorder",
                        },
                    },
                },

                hover = {
                    border = { style = "rounded" },
                    win_options = {
                        winhighlight = {
                            Normal = "NormalFloat",
                            FloatBorder = "FloatBorder",
                        },
                    },
                },
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    {
        "rcarriga/nvim-notify",
        opts = {
            background_colour = "NormalFloat",
            stages = "static",
        }
    },
}
