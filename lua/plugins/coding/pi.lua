return {
    "carderne/pi-nvim",
    opts = {
        socket_path = nil,
        set_default_keymaps = false,
    },
    keys = {
        {
            "<leader>pp",
            ":PiSend<CR>",
            "Prompt to Pi",
        },
        {
            "<leader>ps",
            ":PiSendSelection<CR>",
            mode = "v"
        }
    }
}
