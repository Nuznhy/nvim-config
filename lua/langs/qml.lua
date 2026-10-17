vim.lsp.config("qmlls", {
    filetypes = { "qml" },
    root_markers = {
        { ".qmlls.ini", "pyproject.toml", "setup.py" },
        ".git",
    },
    cmd = function(dispatchers, config)
        local root = config.root_dir or vim.fn.getcwd()
        local candidates = {}

        for _, directory in ipairs({ ".venv", "venv" }) do
            for _, executable in ipairs({ "pyside6-qmlls", "qmlls" }) do
                table.insert(candidates,
                    root .. "/" .. directory .. "/bin/" .. executable)
            end
        end

        -- Also supports externally managed, activated environments.
        if vim.env.VIRTUAL_ENV then
            table.insert(candidates,
                vim.env.VIRTUAL_ENV .. "/bin/pyside6-qmlls")
        end

        vim.list_extend(candidates, { "pyside6-qmlls", "qmlls6", "qmlls" })

        for _, executable in ipairs(candidates) do
            if vim.fn.executable(executable) == 1 then
                return vim.lsp.rpc.start({ executable }, dispatchers, {
                    cwd = root,
                    env = config.cmd_env,
                })
            end
        end

        error("No QML language server found")
    end,
})

return {
    servers = { "qmlls" },
    parsers = { "qmljs" },
}
