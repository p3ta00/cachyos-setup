# CachyOS Shell Environment Setup

A comprehensive shell environment setup script for CachyOS (or any Arch-based distro) featuring modern CLI tools, Dracula theming, and a beautiful terminal experience.

## Features

### Modern CLI Tools
- **eza** - Modern replacement for `ls` with git integration and icons
- **bat** - Better `cat` with syntax highlighting (Dracula theme)
- **fd** - Faster and more user-friendly alternative to `find`
- **ripgrep (rg)** - Ultra-fast text search tool
- **fzf** - Command-line fuzzy finder (Dracula theme)
- **zoxide** - Smarter `cd` command with frecency
- **dust** - Intuitive `du` replacement
- **duf** - User-friendly `df` alternative
- **procs** - Modern `ps` replacement
- **btop** - Beautiful system monitor
- **sd** - Intuitive `sed` alternative
- **delta** - Syntax-highlighting git diff viewer
- **atuin** - Magical shell history with search and sync
- **tealdeer** - Fast tldr client for quick command examples
- **hyperfine** - Command-line benchmarking tool
- **tokei** - Code statistics tool

### Development Tools
- **neovim** - Modern vim-based text editor
- **NvChad** - Blazing fast Neovim config
- **lazygit** - Simple terminal UI for git
- **starship** - Fast, customizable prompt (Dracula theme)
- **yazi** - Blazing fast terminal file manager
- **zellij** - Terminal workspace with layouts (Dracula theme)
- **navi** - Interactive cheatsheet tool

### Shell Environment
- **zsh** - Powerful shell with Oh-My-Zsh
- **oh-my-zsh** - Framework for managing zsh configuration
- **zsh-syntax-highlighting** - Fish-like syntax highlighting
- **zsh-autosuggestions** - Fish-like autosuggestions
- **Ghostty** - Fast, native terminal emulator (Dracula theme)

### Theming
All tools are configured with **Dracula theme** for a consistent, beautiful dark theme experience.

## Directory Structure

```
cachyos-setup/
├── install.sh           # Main installation script
├── README.md            # This file
├── dotfiles/            # Shell configuration files
│   ├── .zshrc          # Main zsh configuration
│   ├── .zshenv         # Zsh environment variables
│   ├── .bashrc         # Bash configuration (fallback)
│   ├── .bash_logout    # Bash logout script
│   ├── .profile        # Profile configuration
│   └── .zsh/           # Zsh completions
├── config/              # Application configurations
│   ├── starship.toml   # Starship prompt config
│   ├── zellij/         # Zellij workspace config
│   ├── yazi/           # Yazi file manager config
│   ├── fastfetch/      # Fastfetch system info config
│   └── htop/           # Htop config
└── fonts/               # JetBrains Mono Nerd Font
```

## Installation

### Prerequisites
- A fresh CachyOS installation (or Arch-based distro)
- Internet connection
- sudo privileges

### Quick Install

1. Copy this entire `cachyos-setup` directory to your new machine
2. Open a terminal and navigate to the directory:
   ```bash
   cd cachyos-setup
   ```
3. Run the installation script:
   ```bash
   ./install.sh
   ```
4. Follow the prompts and let the script do its magic!

### What the Script Does

The installation script will:
1. ✅ Detect your package manager (pacman or apt)
2. ✅ Update system packages
3. ✅ Install core system packages
4. ✅ Install Rust and Cargo
5. ✅ Install all Cargo-based tools
6. ✅ Set up Oh-My-Zsh with plugins
7. ✅ Install JetBrains Mono Nerd Font
8. ✅ Set up Neovim with NvChad
9. ✅ Install Ghostty terminal
10. ✅ Install lazygit and btop
11. ✅ Copy all dotfiles and configs (with backup)
12. ✅ Configure Ghostty with Dracula theme
13. ✅ Set up bat, delta, and atuin
14. ✅ Change default shell to zsh

**Note:** The script will automatically backup your existing configurations to `~/.config_backup_<timestamp>/`

## Post-Installation

After the installation completes:

1. **Logout and login** (or reboot) to apply the shell changes
2. **Open Ghostty terminal** to experience your new setup
3. **Run `nvim`** for the first time to complete NvChad plugin installation
4. **Enjoy your new environment!**

## Key Features & Usage

### Enhanced Shell Commands

The new `.zshrc` includes many convenient aliases:

#### File Operations
```bash
ls        # eza with icons and colors
ll        # eza long format
la        # eza show all files
lt        # eza tree view
cat       # bat with syntax highlighting
```

#### Navigation
```bash
cd <dir>  # Uses zoxide (learns your habits)
..        # Go up one directory
...       # Go up two directories
mkcd      # Create directory and cd into it
```

#### System Monitoring
```bash
top       # Opens btop
du        # Uses dust
df        # Uses duf
ps        # Uses procs
```

#### Git
```bash
lg        # Opens lazygit
gs        # git status
ga        # git add
gc        # git commit
gd        # git diff (with delta)
```

#### Utilities
```bash
help      # Uses tldr for quick examples
zconfig   # Edit .zshrc
nconfig   # Edit nvim config
sconfig   # Edit starship config
zj        # Start zellij with dracula theme
```

### Atuin Shell History

Press `Ctrl+R` to search through your shell history with atuin's powerful interface.

### FZF Fuzzy Finding

- `Ctrl+T` - Search for files
- `Ctrl+R` - Search command history (atuin)
- `Alt+C` - Change directory with fuzzy search

### Starship Prompt

The starship prompt shows:
- Current directory
- Git branch and status
- Programming language versions (Python, Node, Rust, Go, etc.)
- Docker context
- Custom git remote icons (GitHub, GitLab, etc.)

### Zellij Terminal Workspace

Start zellij with Dracula theme:
```bash
zj
```

Key bindings:
- `Ctrl+O` - Open zellij commands
- `Ctrl+T` - New tab
- `Ctrl+P` - New pane
- `Ctrl+N` - Switch panes

## Customization

### Change Themes

All configurations support Dracula theme by default, but you can customize:

- **Starship**: Edit `~/.config/starship.toml`
- **Ghostty**: Edit `~/.config/ghostty/config`
- **Zellij**: Edit `~/.config/zellij/config.kdl`
- **Bat**: Change `BAT_THEME` in `.zshrc`
- **FZF**: Modify `FZF_DEFAULT_OPTS` in `.zshrc`

### Add More Tools

To add more Rust-based tools:
```bash
cargo install <tool-name>
```

## Troubleshooting

### Fonts not showing correctly
```bash
fc-cache -f ~/.local/share/fonts
```

### Zsh not default shell
```bash
chsh -s $(which zsh)
```

### Cargo tools not in PATH
Add to `.zshrc`:
```bash
export PATH="$HOME/.cargo/bin:$PATH"
```

### NvChad plugins not loading
```bash
nvim
# Wait for installation to complete
# Press Enter when prompted
```

## Included Configurations

### .zshrc Features
- Oh-My-Zsh with plugins
- Starship prompt
- Zoxide integration
- Dracula theme for fzf, bat
- Atuin history search
- Modern CLI tool aliases
- Helpful functions (extract, mkcd)
- Git aliases
- Custom completions support

### Starship Configuration
- Minimalist design
- Git integration with custom icons
- Language detection (Python, Node, Rust, Go, etc.)
- Custom git remote symbols
- Dracula color scheme

### Ghostty Configuration
- Dracula color scheme
- JetBrains Mono Nerd Font
- Custom padding
- Shell integration
- No close confirmation

## Package List

### System Packages (pacman)
```
zsh git curl wget base-devel fzf ripgrep bat fd xclip htop
ruby rubygems python python-pip fontconfig unzip neovim go
```

### Cargo Tools
```
starship zoxide yazi-fm yazi-cli zellij navi eza bat fd-find
dust duf procs bottom sd tealdeer git-delta atuin hyperfine tokei
```

### Additional Tools
- lazygit
- btop
- ghostty (via AUR)

## Backup Information

The install script automatically backs up:
- All existing dotfiles in your home directory
- All existing configs in `~/.config/`

Backups are stored in: `~/.config_backup_<timestamp>/`

## Manual Installation Steps

If you prefer to install components individually:

1. **Install Rust**:
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **Install Oh-My-Zsh**:
   ```bash
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. **Install a tool via cargo**:
   ```bash
   cargo install <tool-name>
   ```

4. **Copy configs**:
   ```bash
   cp dotfiles/.zshrc ~/
   cp -r config/* ~/.config/
   ```

## Credits

- **Dracula Theme**: https://draculatheme.com/
- **NvChad**: https://nvchad.com/
- **Starship**: https://starship.rs/
- **Oh-My-Zsh**: https://ohmyz.sh/

## License

Free to use and modify for personal use.

---

**Enjoy your beautiful new shell environment! 🚀**
