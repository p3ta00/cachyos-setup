# Dracula Theme Color Reference

This file contains the official Dracula theme colors for reference when customizing additional tools.

## Dracula Color Palette

```
Background:     #282a36
Current Line:   #44475a
Foreground:     #f8f8f2
Comment:        #6272a4
Cyan:           #8be9fd
Green:          #50fa7b
Orange:         #ffb86c
Pink:           #ff79c6
Purple:         #bd93f9
Red:            #ff5555
Yellow:         #f1fa8c
```

## ANSI Colors (for terminals)

### Normal Colors
```
Black:          #21222c
Red:            #ff5555
Green:          #50fa7b
Yellow:         #f1fa8c
Blue:           #bd93f9
Magenta:        #ff79c6
Cyan:           #8be9fd
White:          #f8f8f2
```

### Bright Colors
```
Bright Black:   #6272a4
Bright Red:     #ff6e6e
Bright Green:   #69ff94
Bright Yellow:  #ffffa5
Bright Blue:    #d6acff
Bright Magenta: #ff92df
Bright Cyan:    #a4ffff
Bright White:   #ffffff
```

## Applied Configurations

### Tools with Dracula Theme Configured:

1. **Ghostty Terminal** (`~/.config/ghostty/config`)
   - Full Dracula palette
   - JetBrains Mono Nerd Font
   - Dark window theme

2. **Bat** (via environment variable in `.zshrc`)
   - `BAT_THEME="Dracula"`
   - Syntax highlighting with Dracula colors

3. **FZF** (in `.zshrc`)
   - Custom Dracula color scheme
   - Matching background, foreground, and accent colors

4. **Git Delta** (git config)
   - `delta.syntax-theme "Dracula"`
   - Side-by-side diffs with Dracula colors

5. **Zellij** (via alias in `.zshrc`)
   - `zellij options --theme dracula`
   - Terminal workspace with Dracula theme

6. **Starship** (`~/.config/starship.toml`)
   - Custom Dracula palette defined
   - All prompt elements use Dracula colors

## Additional Tools to Theme Manually

If you install additional tools, here's how to apply Dracula:

### Alacritty
```yaml
# ~/.config/alacritty/alacritty.yml
colors:
  primary:
    background: '#282a36'
    foreground: '#f8f8f2'
  cursor:
    text: CellBackground
    cursor: CellForeground
  selection:
    text: CellForeground
    background: '#44475a'
  normal:
    black:   '#21222c'
    red:     '#ff5555'
    green:   '#50fa7b'
    yellow:  '#f1fa8c'
    blue:    '#bd93f9'
    magenta: '#ff79c6'
    cyan:    '#8be9fd'
    white:   '#f8f8f2'
  bright:
    black:   '#6272a4'
    red:     '#ff6e6e'
    green:   '#69ff94'
    yellow:  '#ffffa5'
    blue:    '#d6acff'
    magenta: '#ff92df'
    cyan:    '#a4ffff'
    white:   '#ffffff'
```

### Kitty
```conf
# ~/.config/kitty/dracula.conf
foreground            #f8f8f2
background            #282a36
selection_foreground  #ffffff
selection_background  #44475a

# black
color0  #21222c
color8  #6272a4

# red
color1  #ff5555
color9  #ff6e6e

# green
color2  #50fa7b
color10 #69ff94

# yellow
color3  #f1fa8c
color11 #ffffa5

# blue
color4  #bd93f9
color12 #d6acff

# magenta
color5  #ff79c6
color13 #ff92df

# cyan
color6  #8be9fd
color14 #a4ffff

# white
color7  #f8f8f2
color15 #ffffff
```

### Tmux (if you decide to use it)
```conf
# ~/.tmux.conf - Dracula theme
set -g status-style 'bg=#282a36 fg=#f8f8f2'
set -g pane-border-style 'fg=#6272a4'
set -g pane-active-border-style 'fg=#bd93f9'
set -g window-status-current-style 'fg=#282a36 bg=#bd93f9'
set -g message-style 'bg=#44475a fg=#f8f8f2'
```

### Vim/Neovim (in addition to NvChad)
```vim
" Add to init.vim or init.lua
colorscheme dracula
```

For Lua:
```lua
-- init.lua
vim.cmd [[colorscheme dracula]]
```

## Official Dracula Resources

- **Website**: https://draculatheme.com/
- **GitHub**: https://github.com/dracula
- **Color Spec**: https://spec.draculatheme.com/

## Custom Dracula Configurations

You can find Dracula themes for almost any application at:
https://draculatheme.com/

Popular applications with Dracula themes:
- VS Code
- Sublime Text
- Vim
- Emacs
- Obsidian
- Discord
- Slack
- Firefox
- Chrome
- And many more!

---

**Keep your environment consistently beautiful with Dracula! 🧛**
