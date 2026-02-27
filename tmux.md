# tmux cheatsheet

Based on `tmux/.tmux.conf` in this repo.

> **Prefix key:** `C-b` (default tmux prefix, since this config does not override it)

---

## Global (no prefix required)

| Key | Action |
|---|---|
| `Ctrl-p` | Toggle popup session (`popup`): open centered popup, or detach if already in popup session |
| `Alt-h/j/k/l` | Move to pane left/down/up/right |
| `Shift-Left` | Previous window |
| `Shift-Right` | Next window |

---

## Prefix shortcuts (`Prefix` + key)

### Pane navigation & layout

| Key | Action |
|---|---|
| `h/j/k/l` | Select pane left/down/up/right |
| `Left/Down/Up/Right` | Resize current pane by 5 cells (repeatable) |
| `x` | Kill current pane |
| `*` | Swap pane upward |
| `s` | Toggle synchronize-panes |

### Windows & sessions

| Key | Action |
|---|---|
| `c` | Prompt for new window name, then create it |
| `X` | Kill current window |
| `z` | Jump to last window |
| `L` | Choose session |
| `Ctrl-j` | Popup `fzf` session switcher |

### Utilities

| Key | Action |
|---|---|
| `r` | Reload `~/.tmux.conf` |
| `Ctrl-l` | Send literal `Ctrl-l` to pane (clear screen in many shells/apps) |
| `/` | Prompt for a man page topic, then open split with `man <topic>` |

---

## Copy mode (vi keys)

Enter copy mode with default tmux key (`Prefix` + `[`) then:

| Key | Action |
|---|---|
| `v` | Begin selection |
| `Ctrl-v` | Toggle rectangle selection |
| `y` | Copy selection and exit copy mode |
| `Esc` | Cancel copy mode |
| `H` | Move to start of line |
| `L` | Move to end of line |

---

## TPM / plugin notes

This config loads TPM via:

- `run '~/.tmux/plugins/tpm/tpm'`
- `@plugin 'erikw/tmux-powerline'`

Common TPM keys (available when TPM is loaded):

- `Prefix + I` → install plugins
- `Prefix + U` → update plugins
- `Prefix + M-u` → remove unused plugins

---

## Behavior/settings worth knowing

- Mouse enabled
- Clipboard integration enabled (`set-clipboard on`)
- Windows and panes start at index `1`
- Windows auto-renumber after close
- Status bar at top
- Status-right shows `PREFIX` indicator when prefix is active
