return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = true,
        view_options = {
            -- Show files and directories that start with "."
            show_hidden = true
        },
        columns = {
            "icon",
            -- "permissions",
            --"size",
            --"mtime",
        },
        preview_win = {
            update_on_cursor_moved = true,
            preview_method = "fast_scratch",
        },

        preview_split = "right",
        -- git = {
        --     -- Return true to automatically git add/mv/rm files
        --     add = function(path)
        --         return false
        --     end,
        --     mv = function(src_path, dest_path)
        --         return false
        --     end,
        --     rm = function(path)
        --         return false
        --     end,
        -- },
    },
    config = function(_, opts)
        require("oil").setup(opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "OilEnter",
            callback = vim.schedule_wrap(function(args)
                local oil = require("oil")

                if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
                    oil.open_preview({
                        vertical = true,
                        split = "belowright"
                    })
                end
            end),
        })
    end,
    -- Optional dependencies
    dependencies = { { "nvim-tree/nvim-web-devicons" } }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    keys = {
        { '<leader>e', ":Oil<CR>" }
    }
}
