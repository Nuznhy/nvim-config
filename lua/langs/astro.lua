vim.filetype.add({
  extension = {
    astro = "astro",
  },
})

vim.lsp.config("astro", {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = {
    "package.json",
    "astro.config.mjs",
    "astro.config.ts",
    "tsconfig.json",
    "jsconfig.json",
    ".git",
  },
})

vim.lsp.enable("astro")

return {
  servers = { "astro" },
  parsers = { "astro" },
}
