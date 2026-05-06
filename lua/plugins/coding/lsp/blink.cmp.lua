local function ollama_running()
    local handle = io.popen("pgrep -x ollama")
    if not handle then return false end
    local result = handle:read("*a")
    handle:close()
    return result ~= ""
end

local color_cache = {}

local function get_color(doc, kind)
    if not doc or doc == "" then return nil end

    local key = doc .. ":" .. kind
    if color_cache[key] ~= nil then
        return color_cache[key]
    end

    local ok, result = pcall(function()
        return require("nvim-highlight-colors").format(doc, { kind = kind })
    end)

    color_cache[key] = ok and result or false
    return color_cache[key]
end

vim.schedule(function()
  vim.defer_fn(function()
    color_cache = {}
  end, 600000)
end)

return {
    'saghen/blink.cmp',
    dependencies = {
        { 'rafamadriz/friendly-snippets' },
        { 'brenoprata10/nvim-highlight-colors' }
    },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        signature = { enabled = true },
        fuzzy = {
            sorts = {
                'exact',
                'score',
                'sort_text',
            },
        },
        sources = {
            default = { 'lsp', 'path', 'buffer', 'snippets' }
            -- default = function()
            --     local src = { 'lsp', 'path', 'buffer', 'snippets' }
            --
            --     if ollama_running() then
            --         table.insert(src, 'minuet')
            --     end
            --
            --     return src
            -- end,
            -- providers = {
            --     minuet = {
            --         name = 'minuet',
            --         module = 'minuet.blink',
            --         async = true,
            --         timeout_ms = 3000,
            --         score_offset = 50
            --     },
            -- },
        },
        completion = {
            list = { max_items = 50 },
            trigger = { prefetch_on_insert = false },
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            menu = {
                auto_show = true,
                draw = {
                    treesitter = { "lsp" },
                    columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
                    components = {
                        -- customize the drawing of kind icons
                        kind_icon = {
                            text = function(ctx)
                                local color_item = get_color(ctx.item.documentation, ctx.kind)

                                if color_item and color_item.abbr ~= "" then
                                    return color_item.abbr .. ctx.icon_gap
                                end

                                return ctx.kind_icon .. ctx.icon_gap
                            end,

                            highlight = function(ctx)
                                local color_item = get_color(ctx.item.documentation, ctx.kind)

                                if color_item and color_item.abbr_hl_group then
                                    return color_item.abbr_hl_group
                                end

                                return "BlinkCmpKind" .. ctx.kind
                            end,
                        }
                    },
                },
            }
        }
    },
    opts_extend = { "sources.default" }
}
