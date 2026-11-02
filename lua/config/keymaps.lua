-- vim.cmd.cd(vim.fn.getcwd())
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

-- move text from line below to current line --
vim.keymap.set("n", "J", "mzJ`z")

-- keep view centered when jumping --
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- duplicate what is not selected in visual block to next line --
vim.keymap.set("x", "<leader>p", "\"_dP")

-- yank to system buffer --
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

-- file view hop / split --
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>ss', ':e #<CR>', { desc = 'Switch to previous file' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>S', ':vert sf #<CR>')
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- lsp keymap --
-- Navigation
local test = ''

print(test)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)       -- Find usages
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition)

-- Information
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.document_symbol)
vim.keymap.set('n', '<leader>lS', vim.lsp.buf.workspace_symbol)

-- Actions
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

-- Call hierarchy
vim.keymap.set('n', '<leader>li', vim.lsp.buf.incoming_calls)
vim.keymap.set('n', '<leader>lo', vim.lsp.buf.outgoing_calls)

-- Diagnostics
vim.diagnostic.config({ jump = { float = true } })

vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = 1 })
end)

vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = -1 })
end)

vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setqflist)

local function toggle_checkbox()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(0, row-1, row, false)[1] or ""

  -- match "- [ ]", "- [x]" etc.
  local prefix, state, suffix = line:match("^(.-%[)(.)(%].*)$")
  if prefix then
    -- toggle between space and x
    local new_state = (state == "x") and " " or "x"
    line = prefix .. new_state .. suffix
  else
    -- no checkbox found — insert at cursor start
    line = "- [ ] " .. line
  end

  vim.api.nvim_buf_set_lines(0, row-1, row, false, { line })
end

vim.keymap.set(
  "n",
  "<leader>tt",
  toggle_checkbox,
  { desc = "Toggle Markdown Checkbox", buffer = true }
)
