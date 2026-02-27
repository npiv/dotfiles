# tmux cheatsheet

Based on `tmux/.tmux.conf` in this repo.

> **Prefix keys:** `Ctrl-Space` (primary) and `Ctrl-b` (secondary)

---

## Global (no prefix required)

| Key | Action |
|---|---|
| `Alt-h/j/k/l` | Move to pane left/down/up/right |
| `Shift-Left` | Previous window |
| `Shift-Right` | Next window |
| `Alt-1..9` | Jump directly to window 1..9 |

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

### Windows

| Key | Action |
|---|---|
| `c` | Create a new window in current pane path |
| `X` | Kill current window |
| `z` | Jump to last window |

### Sessions

| Key | Action |
|---|---|
| `C` | Create new session in current pane path |
| `R` | Rename current session |
| `K` | Kill current session |
| `P` | Switch to previous session |
| `N` | Switch to next session |
| `Ctrl-j` | Popup `fzf` session picker and switch |

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
- `detach-on-destroy off` (tries to keep client attached when destroying sessions/windows)
- Status bar at top
- Status-right shows `PREFIX` indicator when prefix is active
