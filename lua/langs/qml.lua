vim.lsp.config("qmlls", {
    cmd = {
        "qmlls6",
    },
    filetypes = {"qml"}
})

return {
    servers = { "qmlls" },
    parsers = { "qmljs" }
}
