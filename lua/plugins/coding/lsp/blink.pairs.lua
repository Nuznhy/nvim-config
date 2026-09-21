 return {
        "saghen/blink.pairs",
        dependencies = {
            "saghen/blink.lib",
        },

        version = "*",

        build = function()
            require("blink.pairs").download():pwait(60000)
        end,

        ---@module "blink.pairs"
        ---@type blink.pairs.Config
        opts = {},
    }
