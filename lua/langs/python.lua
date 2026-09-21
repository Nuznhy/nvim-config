-- vim.lsp.config("pylsp", {
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodestyle = { enabled = false },
--                 mccabe = { enabled = false },
--                 pyflakes = { enabled = false },
--                 flake8 = { enabled = false },
--                 ruff = { enabled = false },
--                 pylsp_mypy = {
--                     enabled = true,
--                     live_mode = true
--                 },
--             }
--         }
--     }
-- })

return {
    servers = {
        "basedpyright",
        "ruff",
        "pytest_language_server",
    },
    parsers = {
        "python",
        "rst",
        "toml",
    },
}
