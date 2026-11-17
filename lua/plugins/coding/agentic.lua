-- Agentic exposes model/options controls as session-bound buffer mappings.
-- Reuse those callbacks so the menu also works from code or with chat hidden.
local function widget_action(lhs, target_session)
  return function()
    local session = target_session or require("agentic.session_registry").current()
    if not session then
      vim.notify("Open a chat with Space i first", vim.log.levels.INFO, { title = "Agentic" })
      return
    end

    local mapping = vim.api.nvim_buf_call(session.widget.buf_nrs.input, function()
      return vim.fn.maparg(lhs, "n", false, true)
    end)
    if mapping.buffer == 1 and type(mapping.callback) == "function" then
      mapping.callback()
    else
      vim.notify("This chat control is unavailable", vim.log.levels.WARN, { title = "Agentic" })
    end
  end
end

local function new_session()
  local registry = require("agentic.session_registry")
  registry.select_provider(function(provider)
    if not provider then return end

    vim.schedule(function()
      -- Keep Agentic's keep/destroy choice and wait for this specific session.
      -- Models are only known after the selected provider finishes starting.
      registry.create_with_current_session_guard(function(session)
        registry.show_session(session.session_key)
        session:on_session_ready(function()
          if registry.get(session.session_key) ~= session or registry.visible_here() ~= session then
            return
          end
          vim.cmd("stopinsert")
          widget_action("gm", session)()
        end)
      end, provider)
    end)
  end)
end

local function toggle_mode()
  local session = require("agentic.session_registry").current()
  if not session then
    widget_action("gM")()
    return
  end

  local options = session.config_options
  local legacy = options.mode == nil
  local function has_mode(id)
    if legacy then return options.legacy_agent_modes:get_mode(id) ~= nil end
    return options:get_mode(id) ~= nil
  end

  if has_mode("plan") and has_mode("default") then
    options:handle_mode_change(options:get_mode_id() == "plan" and "default" or "plan", legacy)
  else
    -- Other providers may use different modes; let the user choose explicitly.
    widget_action("gM", session)()
  end
end

local function actions()
  local agentic = require("agentic")
  local items = {
    { "Switch model                         gm", widget_action("gm") },
    { "Switch provider (Claude / Codex)      gp", agentic.switch_provider },
    { "Switch live chat session              gs", agentic.select_session },
    { "Restore saved session", agentic.restore_session },
    { "New chat session (choose provider + model)", new_session },
    { "Stop response                        Ctrl+C", agentic.stop_generation },
    { "Open / focus prompt", function() agentic.open({ auto_add_to_context = false }) end },
    { "Add current file to context", agentic.add_file },
    { "Add current line diagnostics", agentic.add_current_line_diagnostics },
    { "Add buffer diagnostics", agentic.add_buffer_diagnostics },
    { "Next chat                            ]i", agentic.next_session },
    { "Previous chat                        [i", agentic.prev_session },
    { "Toggle plan / default mode           Shift+Tab", toggle_mode },
    { "Select agent mode                    gM", widget_action("gM") },
    { "Change reasoning effort              ge", widget_action("ge") },
    { "Model / agent options                go", widget_action("go") },
    { "Rotate chat layout", agentic.rotate_layout },
    { "Hide chat                            q", agentic.close },
  }

  require("mini.pick").ui_select(items, {
    prompt = "Agentic actions | type to search",
    format_item = function(item) return item[1] end,
  }, function(item)
    if item then
      -- Let the menu close and restore the source window before opening a picker.
      vim.schedule(item[2])
    end
  end)
end

return {
  "carlos-algms/agentic.nvim",
  dependencies = { "nvim-mini/mini.pick" },
  cmd = "AgenticActions",

  --- @type agentic.PartialUserConfig
  opts = {
    provider = "claude-agent-acp",
    headers = {
      input = { title = "Prompt (Esc, Space m: menu | Ctrl+C: stop)" },
    },
    keymaps = {
      -- These shortcuts only exist inside Agentic; editor mappings stay intact.
      widget = {
        change_mode = "gM",
        change_thought_level = "ge",
        switch_model = "gm",
        switch_provider = "gp",
        select_session = "gs",
        next_session = "]i",
        prev_session = "[i",
        open_options = "go",
      },
    },
  },

  keys = {
    {
      "<leader>i",
      function()
        if require("agentic.session_registry").current() then
          require("agentic").toggle({ auto_add_to_context = false })
        else
          new_session()
        end
      end,
      desc = "Agentic: toggle chat",
    },
    {
      "<leader>i",
      function() require("agentic").add_selection() end,
      mode = "x",
      desc = "Agentic: send selection to chat",
    },
    {
      "<leader>m",
      actions,
      desc = "Agentic: action menu",
    },
  },

  config = function(_, opts)
    require("agentic").setup(opts)
    vim.api.nvim_create_user_command("AgenticActions", actions, { desc = "Open Agentic action menu" })
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("AgenticShortcuts", { clear = true }),
      pattern = "Agentic*",
      callback = function(event)
        vim.keymap.set({ "n", "i" }, "<C-c>", function()
          require("agentic").stop_generation()
        end, { buffer = event.buf, desc = "Agentic: stop response" })
        vim.keymap.set({ "n", "i" }, "<S-Tab>", toggle_mode,
          { buffer = event.buf, desc = "Agentic: toggle plan / default mode" })
      end,
    })
  end,
}
