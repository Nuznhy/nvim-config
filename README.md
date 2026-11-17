
> [!IMPORTANT]
> tree-sitter-cli required version 26 or higher to compile parsers

## Required
- tree-sitter-cli
- lua
- python

# Install

> [!WARNING]
> Make your config backup just in case
>``` sh 
> mv ~/.config/nvim{,.bak}
>```

> [!TIP]
> Make your nvim backup just in case
>``` sh
> mv ~/.local/share/nvim{,.bak}
> mv ~/.local/state/nvim{,.bak}
> mv ~/.cache/nvim{,.bak}
>```

> Clone config to ~/.config/nvim
>``` sh
> git clone https://github.com/Nuznhy/nvim-config.git ~/.config/nvim
>```

## Agentic chat

Start with two shortcuts: **Space i** toggles chat, and **Space m** opens a
searchable action menu. Press `Esc` first when typing in the prompt.
The existing `Space a` autosave toggle is unchanged.

| Keys | Action |
| --- | --- |
| `Space i` in normal mode | Show / hide chat |
| `Space i` in visual mode | Add selected code to chat and focus the prompt |
| `Space m` in normal mode | Open the Agentic action menu |

In the menu, type `model`, `provider`, `session`, `plan`, `effort`, or `stop` to filter actions,
then press `Enter`. Use arrow keys or `Ctrl+n` / `Ctrl+p` to move, and `Esc`
to dismiss the menu. You can also open it with `:AgenticActions`.
It uses the existing mini.pick picker, including for provider/model/session lists.

To start a new chat, use **Space m**, type `new`, and press `Enter`:

1. Pick a provider, such as Claude or Codex.
2. If a chat already exists, choose whether to keep it in the background or destroy it.
3. Once the provider connects, pick a model from its available models.

The first **Space i** also uses this flow when no live chat exists. Cancelling
the provider or keep/destroy picker creates no new session. Cancelling the
model picker keeps the new session on the provider's default model. If you
hide the chat or switch away while it connects, use `gm` when you return.

The menu includes saved-session restore, prompt focus, file context,
diagnostics, reasoning effort, and layout changes. Model/options actions target
the current chat, even when the menu is opened from code or the chat is hidden.
Open a chat first if you have not started one yet.

Optional shortcuts inside Agentic buffers (normal mode unless noted):

| Keys | Action |
| --- | --- |
| `Ctrl+c` in normal or insert mode | Stop the running response; keep the session and draft |
| `gm` | Switch model |
| `ge` | Change reasoning effort (for example, low / medium / high) |
| `gp` | Switch provider (Claude / Codex / others) |
| `gs` | Pick a live chat session, including hidden chats |
| `]i` / `[i` | Next / previous live chat |
| `go` | Open model / agent options |
| `Shift+Tab` in normal or insert mode | Toggle between plan and default mode |
| `gM` | Pick any supported agent mode |
| `q` | Hide chat; the session keeps running |
| `Enter` in normal mode / `Ctrl+s` | Submit the prompt |

Models, reasoning effort, modes, and saved-session restore depend on the provider.
`Shift+Tab` toggles directly when both `plan` and `default` are advertised;
otherwise it opens the provider's mode picker. Use **Space m**, then `effort`,
to change reasoning effort from anywhere, including while the chat is hidden.
Opening or switching chats does not add the current file to context; use
the menu's **Add current file to context** action explicitly. When creating a
new chat, choose to keep the existing session in the background to return to
it through **Switch live chat session**.

These replace the previous `Space A...` shortcuts. See the
[Agentic keybinding documentation](https://github.com/carlos-algms/agentic.nvim#built-in-keybindings)
for the remaining widget controls.
