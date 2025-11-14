#!/bin/bash
#
# VMware Workstation Installation Script for CachyOS
# This script installs VMware Workstation and builds kernel modules for CachyOS
#
# Usage: sudo ./install-vmware-workstation.sh [path-to-vmware-bundle]
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    log_error "This script must be run as root (use sudo)"
    exit 1
fi

# Find VMware installer bundle
VMWARE_BUNDLE="$1"
if [ -z "$VMWARE_BUNDLE" ]; then
    log_info "Searching for VMware Workstation bundle in ~/Downloads..."
    VMWARE_BUNDLE=$(find /home/*/Downloads -name "VMware-Workstation-Full-*.bundle" -type f 2>/dev/null | head -n 1)

    if [ -z "$VMWARE_BUNDLE" ]; then
        log_error "VMware Workstation bundle not found in Downloads"
        log_error "Usage: sudo $0 [path-to-vmware-bundle]"
        exit 1
    fi
fi

if [ ! -f "$VMWARE_BUNDLE" ]; then
    log_error "VMware bundle not found: $VMWARE_BUNDLE"
    exit 1
fi

log_info "Found VMware bundle: $VMWARE_BUNDLE"

# Check for required packages
log_info "Checking for required packages..."
REQUIRED_PACKAGES="linux-cachyos-headers base-devel clang lld"
MISSING_PACKAGES=""

for pkg in $REQUIRED_PACKAGES; do
    if ! pacman -Q $pkg &>/dev/null; then
        MISSING_PACKAGES="$MISSING_PACKAGES $pkg"
    fi
done

if [ -n "$MISSING_PACKAGES" ]; then
    log_warn "Missing required packages:$MISSING_PACKAGES"
    log_info "Installing missing packages..."
    pacman -S --needed --noconfirm $MISSING_PACKAGES
fi

# Create /etc/init.d if it doesn't exist (needed for VMware installer)
if [ ! -d /etc/init.d ]; then
    log_info "Creating /etc/init.d directory..."
    mkdir -p /etc/init.d
fi

# Make installer executable
log_info "Making installer executable..."
chmod +x "$VMWARE_BUNDLE"

# Run VMware installer
log_info "Running VMware Workstation installer..."
if "$VMWARE_BUNDLE" --console --required --eulas-agreed; then
    log_info "VMware Workstation installed successfully"
else
    log_error "VMware Workstation installation failed"
    exit 1
fi

# Check if vmware is installed
if ! command -v vmware &>/dev/null; then
    log_error "VMware installation verification failed"
    exit 1
fi

VMWARE_VERSION=$(vmware --version)
log_info "Installed: $VMWARE_VERSION"

# Build kernel modules
log_info "Building VMware kernel modules..."
KERNEL_VERSION=$(uname -r)
BUILD_DIR="/tmp/vmware-build-$$"

mkdir -p "$BUILD_DIR"

# Extract module sources
log_info "Extracting module sources..."
tar -xf /usr/lib/vmware/modules/source/vmmon.tar -C "$BUILD_DIR/"
tar -xf /usr/lib/vmware/modules/source/vmnet.tar -C "$BUILD_DIR/"

# Build vmmon module
log_info "Building vmmon module..."
if make -C "$BUILD_DIR/vmmon-only" CC=clang LD=ld.lld HOSTLD=ld.lld &>/dev/null; then
    log_info "vmmon module built successfully"
else
    log_error "Failed to build vmmon module"
    log_warn "Check /tmp/vmware-build-$$/vmmon-only for details"
    exit 1
fi

# Build vmnet module
log_info "Building vmnet module..."
if make -C "$BUILD_DIR/vmnet-only" CC=clang LD=ld.lld HOSTLD=ld.lld &>/dev/null; then
    log_info "vmnet module built successfully"
else
    log_error "Failed to build vmnet module"
    log_warn "Check /tmp/vmware-build-$$/vmnet-only for details"
    exit 1
fi

# Install kernel modules
log_info "Installing kernel modules..."
mkdir -p "/lib/modules/$KERNEL_VERSION/misc"
cp "$BUILD_DIR/vmmon-only/vmmon.ko" "/lib/modules/$KERNEL_VERSION/misc/"
cp "$BUILD_DIR/vmnet-only/vmnet.ko" "/lib/modules/$KERNEL_VERSION/misc/"

# Update module dependencies
log_info "Updating module dependencies..."
depmod -a

# Load kernel modules
log_info "Loading kernel modules..."
modprobe vmmon
modprobe vmnet

# Verify modules are loaded
if lsmod | grep -q vmmon && lsmod | grep -q vmnet; then
    log_info "Kernel modules loaded successfully"
else
    log_error "Failed to load kernel modules"
    exit 1
fi

# Start VMware services
log_info "Starting VMware services..."
systemctl enable vmware
systemctl start vmware

# Verify service status
if systemctl is-active --quiet vmware; then
    log_info "VMware services started successfully"
else
    log_error "VMware services failed to start"
    systemctl status vmware --no-pager
    exit 1
fi

# Cleanup
log_info "Cleaning up build directory..."
rm -rf "$BUILD_DIR"

# Print summary
echo
log_info "====================================="
log_info "VMware Workstation Installation Complete!"
log_info "====================================="
echo
log_info "Version: $VMWARE_VERSION"
log_info "Kernel modules: vmmon, vmnet"
log_info "Service status: $(systemctl is-active vmware)"
echo
log_info "You can launch VMware Workstation with:"
echo "  - GUI: vmware"
echo "  - Player: vmplayer"
echo
log_info "To check service status: systemctl status vmware"
echo

exit 0
