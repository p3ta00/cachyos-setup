# CachyOS Setup Scripts

A collection of installation and setup scripts for CachyOS Linux, featuring modern CLI tools, shell environment setup with Dracula theming, and system configuration scripts.

## Scripts

### Shell Environment Setup

A comprehensive shell environment setup script featuring modern CLI tools, Dracula theming, and a beautiful terminal experience.

**File:** `install.sh`

#### Features

##### Modern CLI Tools
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

##### Development Tools
- **neovim** - Modern vim-based text editor
- **NvChad** - Blazing fast Neovim config
- **lazygit** - Simple terminal UI for git
- **starship** - Fast, customizable prompt (Dracula theme)
- **yazi** - Blazing fast terminal file manager
- **zellij** - Terminal workspace with layouts (Dracula theme)
- **navi** - Interactive cheatsheet tool

##### Shell Environment
- **zsh** - Powerful shell with Oh-My-Zsh
- **oh-my-zsh** - Framework for managing zsh configuration
- **zsh-syntax-highlighting** - Fish-like syntax highlighting
- **zsh-autosuggestions** - Fish-like autosuggestions
- **Ghostty** - Fast, native terminal emulator (Dracula theme)

### VMware Workstation Installation

**File:** `install-vmware-workstation.sh`

Automated installation script for VMware Workstation on CachyOS. This script:
- Installs VMware Workstation from the official bundle
- Builds kernel modules (vmmon, vmnet) with clang/lld to match CachyOS kernel
- Loads kernel modules and starts services
- Verifies installation

#### Prerequisites

- CachyOS Linux
- VMware Workstation bundle file (download from VMware website)
- Root/sudo access

#### Usage

```bash
# Download VMware Workstation bundle from https://www.vmware.com/products/workstation-pro.html

# Make the script executable
chmod +x install-vmware-workstation.sh

# Run with sudo (auto-detects bundle in ~/Downloads)
sudo ./install-vmware-workstation.sh

# Or specify bundle path explicitly
sudo ./install-vmware-workstation.sh /path/to/VMware-Workstation-Full-*.bundle
```

#### What it does

1. Checks for required packages (kernel headers, build tools, clang, lld)
2. Installs missing dependencies via pacman
3. Runs VMware Workstation installer
4. Builds vmmon and vmnet kernel modules using clang (matching CachyOS kernel compiler)
5. Installs and loads kernel modules
6. Enables and starts VMware services
7. Verifies everything is working

#### Troubleshooting

If the installation fails:

1. Check kernel headers are installed:
   ```bash
   pacman -Q linux-cachyos-headers
   ```

2. Verify build tools:
   ```bash
   pacman -Q base-devel clang lld
   ```

3. Check VMware service status:
   ```bash
   systemctl status vmware
   ```

4. Verify kernel modules:
   ```bash
   lsmod | grep -E "vmmon|vmnet"
   ```

## Shell Environment Installation

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

## Contributing

Feel free to submit issues or pull requests for improvements.

## License

MIT License - Feel free to use and modify these scripts.

---

**Enjoy your CachyOS setup! 🚀**
