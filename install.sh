#!/usr/bin/env bash

# ═══════════════════════════════════════════════════════════════════
# CachyOS Shell Environment Setup Script
# ═══════════════════════════════════════════════════════════════════

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ───────────────────────────────────────────────────────────────────
# Helper Functions
# ───────────────────────────────────────────────────────────────────

print_header() {
    echo -e "\n${PURPLE}═══════════════════════════════════════════════════════════════════${NC}"
    echo -e "${PURPLE}  $1${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════════${NC}\n"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect package manager
detect_package_manager() {
    if command_exists pacman; then
        PKG_MANAGER="pacman"
        PKG_INSTALL="sudo pacman -S --noconfirm"
        PKG_UPDATE="sudo pacman -Syu --noconfirm"
    elif command_exists apt; then
        PKG_MANAGER="apt"
        PKG_INSTALL="sudo apt install -y"
        PKG_UPDATE="sudo apt update && sudo apt upgrade -y"
    else
        print_error "No supported package manager found (pacman or apt)"
        exit 1
    fi
    print_info "Detected package manager: $PKG_MANAGER"
}

# ───────────────────────────────────────────────────────────────────
# System Packages Installation
# ───────────────────────────────────────────────────────────────────

install_system_packages() {
    print_header "Installing System Packages"

    print_info "Updating system packages..."
    $PKG_UPDATE

    if [ "$PKG_MANAGER" = "pacman" ]; then
        PACKAGES=(
            zsh
            git
            curl
            wget
            base-devel
            fzf
            ripgrep
            bat
            fd
            xclip
            htop
            ruby
            rubygems
            python
            python-pip
            fontconfig
            unzip
            neovim
            go
            ttf-jetbrains-mono-nerd
            zellij
        )
    else # apt
        PACKAGES=(
            zsh
            git
            curl
            wget
            build-essential
            fzf
            ripgrep
            bat
            fd-find
            xclip
            htop
            ruby
            ruby-rubygems
            python3
            python3-pip
            fontconfig
            unzip
            neovim
            golang
        )
    fi

    print_info "Installing packages: ${PACKAGES[*]}"
    $PKG_INSTALL "${PACKAGES[@]}"

    print_success "System packages installed"
}

# ───────────────────────────────────────────────────────────────────
# Rust & Cargo Setup
# ───────────────────────────────────────────────────────────────────

install_rust() {
    print_header "Installing Rust & Cargo"

    if command_exists rustc && command_exists cargo; then
        print_success "Rust already installed"
    else
        print_info "Installing Rust via rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        print_success "Rust installed"
    fi
}

# ───────────────────────────────────────────────────────────────────
# Cargo Tools Installation
# ───────────────────────────────────────────────────────────────────

install_cargo_tools() {
    print_header "Installing Cargo Tools"

    # Make sure cargo is in PATH
    export PATH="$HOME/.cargo/bin:$PATH"

    CARGO_TOOLS=(
        "starship"      # Prompt
        "zoxide"        # Better cd
        "yazi-fm"       # File manager
        "yazi-cli"      # Yazi CLI
        "navi"          # Cheatsheet
        "eza"           # Better ls
        "bat"           # Better cat (if not from system)
        "fd-find"       # Better find
        "dust"          # Better du
        "duf"           # Better df
        "procs"         # Better ps
        "bottom"        # Better top
        "sd"            # Better sed
        "tealdeer"      # Fast tldr
        "git-delta"     # Better git diff
        "atuin"         # Shell history
        "hyperfine"     # Benchmarking
        "tokei"         # Code stats
    )

    for tool in "${CARGO_TOOLS[@]}"; do
        BINARY_NAME=$(echo "$tool" | cut -d'-' -f1)
        if command_exists "$BINARY_NAME"; then
            print_success "$tool already installed"
        else
            print_info "Installing $tool..."
            cargo install "$tool" || print_warning "Failed to install $tool"
        fi
    done

    print_success "Cargo tools installed"
}

# ───────────────────────────────────────────────────────────────────
# Oh-My-Zsh Installation
# ───────────────────────────────────────────────────────────────────

install_oh_my_zsh() {
    print_header "Installing Oh-My-Zsh"

    if [ -d "$HOME/.oh-my-zsh" ]; then
        print_success "Oh-My-Zsh already installed"
    else
        print_info "Installing Oh-My-Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh-My-Zsh installed"
    fi

    # Install zsh plugins
    print_info "Installing zsh plugins..."

    # zsh-syntax-highlighting
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
            "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
        print_success "zsh-syntax-highlighting installed"
    fi

    # zsh-autosuggestions
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git \
            "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
        print_success "zsh-autosuggestions installed"
    fi
}

# ───────────────────────────────────────────────────────────────────
# Fonts Installation
# ───────────────────────────────────────────────────────────────────

install_fonts() {
    print_header "Installing Fonts"

    FONTS_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONTS_DIR"

    if [ -d "$SCRIPT_DIR/fonts" ]; then
        print_info "Copying JetBrains Mono Nerd Font..."
        cp -r "$SCRIPT_DIR/fonts/"*.ttf "$FONTS_DIR/" 2>/dev/null || true

        print_info "Updating font cache..."
        fc-cache -f "$FONTS_DIR"

        print_success "Fonts installed"
    else
        print_warning "Fonts directory not found, skipping..."
    fi
}

# ───────────────────────────────────────────────────────────────────
# Neovim Setup
# ───────────────────────────────────────────────────────────────────

install_neovim_config() {
    print_header "Setting up Neovim with NvChad"

    # Backup existing nvim config
    if [ -d "$HOME/.config/nvim" ]; then
        print_warning "Backing up existing nvim config..."
        mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    print_info "Cloning NvChad starter config..."
    git clone https://github.com/NvChad/starter "$HOME/.config/nvim"

    print_success "NvChad installed (run 'nvim' to complete setup)"
}

# ───────────────────────────────────────────────────────────────────
# Ghostty Terminal Installation
# ───────────────────────────────────────────────────────────────────

install_ghostty() {
    print_header "Installing Ghostty Terminal"

    if command_exists ghostty; then
        print_success "Ghostty already installed"
        return
    fi

    print_info "Installing Ghostty..."

    if [ "$PKG_MANAGER" = "pacman" ]; then
        # Try to install from AUR using yay or paru
        if command_exists yay; then
            yay -S --noconfirm ghostty || print_warning "Failed to install ghostty via yay"
        elif command_exists paru; then
            paru -S --noconfirm ghostty || print_warning "Failed to install ghostty via paru"
        else
            print_warning "No AUR helper found. Please install ghostty manually"
            print_info "Visit: https://ghostty.org"
        fi
    else
        print_warning "Ghostty not available in apt. Please install manually"
        print_info "Visit: https://ghostty.org"
    fi
}

# ───────────────────────────────────────────────────────────────────
# Lazygit Installation
# ───────────────────────────────────────────────────────────────────

install_lazygit() {
    print_header "Installing Lazygit"

    if command_exists lazygit; then
        print_success "Lazygit already installed"
        return
    fi

    print_info "Installing lazygit..."

    if [ "$PKG_MANAGER" = "pacman" ]; then
        sudo pacman -S --noconfirm lazygit
    else
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit lazygit.tar.gz
    fi

    print_success "Lazygit installed"
}

# ───────────────────────────────────────────────────────────────────
# Btop Installation
# ───────────────────────────────────────────────────────────────────

install_btop() {
    print_header "Installing Btop"

    if command_exists btop; then
        print_success "Btop already installed"
        return
    fi

    print_info "Installing btop..."

    if [ "$PKG_MANAGER" = "pacman" ]; then
        sudo pacman -S --noconfirm btop
    else
        sudo apt install -y btop || print_warning "Failed to install btop from apt"
    fi

    print_success "Btop installed"
}

# ───────────────────────────────────────────────────────────────────
# Configuration Files
# ───────────────────────────────────────────────────────────────────

install_dotfiles() {
    print_header "Installing Configuration Files"

    # Backup existing configs
    BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"

    # Backup home dotfiles
    for file in .zshrc .zshenv .bashrc .bash_logout .profile; do
        if [ -f "$HOME/$file" ]; then
            print_info "Backing up $file..."
            cp "$HOME/$file" "$BACKUP_DIR/"
        fi
    done

    # Install dotfiles from script directory
    if [ -d "$SCRIPT_DIR/dotfiles" ]; then
        print_info "Installing dotfiles..."

        cp "$SCRIPT_DIR/dotfiles/.zshrc" "$HOME/"
        cp "$SCRIPT_DIR/dotfiles/.zshenv" "$HOME/"
        cp "$SCRIPT_DIR/dotfiles/.bashrc" "$HOME/"
        cp "$SCRIPT_DIR/dotfiles/.bash_logout" "$HOME/"
        cp "$SCRIPT_DIR/dotfiles/.profile" "$HOME/"

        # Copy .zsh directory if it exists
        if [ -d "$SCRIPT_DIR/dotfiles/.zsh" ]; then
            cp -r "$SCRIPT_DIR/dotfiles/.zsh" "$HOME/"
        fi

        print_success "Dotfiles installed"
    fi

    # Install config directory files
    if [ -d "$SCRIPT_DIR/config" ]; then
        print_info "Installing config files..."

        mkdir -p "$HOME/.config"

        # Copy each config directory/file
        for item in "$SCRIPT_DIR/config/"*; do
            if [ -e "$item" ]; then
                basename_item=$(basename "$item")
                if [ -e "$HOME/.config/$basename_item" ]; then
                    print_info "Backing up existing $basename_item..."
                    cp -r "$HOME/.config/$basename_item" "$BACKUP_DIR/"
                fi
                cp -r "$item" "$HOME/.config/"
                print_success "Installed $basename_item"
            fi
        done
    fi

    print_info "Backup location: $BACKUP_DIR"
}

# ───────────────────────────────────────────────────────────────────
# Ghostty Configuration
# ───────────────────────────────────────────────────────────────────

create_ghostty_config() {
    print_header "Creating Ghostty Configuration"

    mkdir -p "$HOME/.config/ghostty"

    # Skip if config already exists (likely installed from config folder)
    if [ -f "$HOME/.config/ghostty/config" ]; then
        print_success "Ghostty config already exists, skipping..."
        return
    fi

    cat > "$HOME/.config/ghostty/config" << 'EOF'
# Ghostty Configuration - Dracula Theme

# Font
font-family = "JetBrainsMono Nerd Font"
font-size = 12

# Theme - Dracula
background = 282a36
foreground = f8f8f2

# Cursor
cursor-color = f8f8f2

# Selection
selection-background = 44475a
selection-foreground = f8f8f2

# Normal colors
palette = 0=#21222c
palette = 1=#ff5555
palette = 2=#50fa7b
palette = 3=#f1fa8c
palette = 4=#bd93f9
palette = 5=#ff79c6
palette = 6=#8be9fd
palette = 7=#f8f8f2

# Bright colors
palette = 8=#6272a4
palette = 9=#ff6e6e
palette = 10=#69ff94
palette = 11=#ffffa5
palette = 12=#d6acff
palette = 13=#ff92df
palette = 14=#a4ffff
palette = 15=#ffffff

# Window
window-padding-x = 10
window-padding-y = 10
window-theme = dark

# Shell
shell-integration = zsh

# Misc
confirm-close-surface = false
EOF

    print_success "Ghostty config created"
}

# ───────────────────────────────────────────────────────────────────
# Additional Tool Configurations
# ───────────────────────────────────────────────────────────────────

setup_additional_configs() {
    print_header "Setting up Additional Tool Configurations"

    # Bat theme
    print_info "Setting up bat themes..."
    mkdir -p "$(bat --config-dir)/themes"
    cd "$(bat --config-dir)/themes"
    curl -O https://raw.githubusercontent.com/dracula/sublime/master/Dracula.tmTheme 2>/dev/null || true
    bat cache --build
    cd - > /dev/null

    # Git delta config
    print_info "Configuring git delta..."
    git config --global core.pager "delta"
    git config --global interactive.diffFilter "delta --color-only"
    git config --global delta.navigate true
    git config --global delta.side-by-side true
    git config --global delta.line-numbers true
    git config --global delta.syntax-theme "Dracula"

    # Atuin initialization
    if command_exists atuin; then
        print_info "Initializing atuin..."
        atuin import auto || true
    fi

    print_success "Additional configurations complete"
}

# ───────────────────────────────────────────────────────────────────
# Change Default Shell
# ───────────────────────────────────────────────────────────────────

change_shell() {
    print_header "Changing Default Shell to Zsh"

    if [ "$SHELL" = "$(which zsh)" ]; then
        print_success "Default shell is already zsh"
    else
        print_info "Changing default shell to zsh..."
        chsh -s "$(which zsh)"
        print_success "Default shell changed to zsh (logout and login to apply)"
    fi
}

# ───────────────────────────────────────────────────────────────────
# Main Installation Flow
# ───────────────────────────────────────────────────────────────────

main() {
    clear
    print_header "CachyOS Shell Environment Setup"

    print_info "This script will install and configure:"
    echo "  • Modern CLI tools (eza, bat, fd, rg, fzf, etc.)"
    echo "  • Zsh with Oh-My-Zsh and plugins"
    echo "  • Starship prompt (Dracula theme)"
    echo "  • Neovim with NvChad"
    echo "  • Ghostty terminal (Dracula theme)"
    echo "  • Development tools (lazygit, btop, delta, atuin, etc.)"
    echo "  • All dotfiles and configurations"
    echo ""

    read -p "Continue with installation? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Installation cancelled"
        exit 0
    fi

    # Detect system
    detect_package_manager

    # Run installations
    install_system_packages
    install_rust
    install_cargo_tools
    install_oh_my_zsh
    install_fonts
    install_neovim_config
    install_ghostty
    install_lazygit
    install_btop
    install_dotfiles
    create_ghostty_config
    setup_additional_configs
    change_shell

    # Final message
    print_header "Installation Complete!"

    echo -e "${GREEN}Your shell environment has been configured!${NC}\n"
    echo "Next steps:"
    echo "  1. Logout and login (or reboot) to apply shell changes"
    echo "  2. Open Ghostty terminal"
    echo "  3. Run 'nvim' to complete NvChad setup"
    echo "  4. Enjoy your new shell environment!"
    echo ""
    echo "Backup location: $BACKUP_DIR"
    echo ""
}

# Run main function
main "$@"
