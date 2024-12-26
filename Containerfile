FROM quay.io/fedora/fedora-coreos:testing

# Update packages that commonly cause build issues
RUN rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        nfs-utils-coreos \
        || true && \
    ostree container commit

# Install extra repositories 
RUN rpm-ostree install -y --allow-inactive \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    curl -Lo /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo && \
    ostree container commit

# System 
RUN rpm-ostree install -y --allow-inactive \
    cockpit \
    cockpit-machines \
    cockpit-ostree \
    cockpit-podman \
    cockpit-system \
    cockpit-ws \
    man-db \
    man-pages \
    openssh \
    openssl \
    plocate \
    podman \
    podman-compose \
    syncthing \
    tailscale \
    zsh \
    zsh-autosuggestions && \
    ostree container commit

# Applications 
RUN rpm-ostree install -y --allow-inactive \
    bc \
    distrobox \
    perl-Image-ExifTool \
    htop \
    neovim \
    nvtop \
    openvpn \
    ranger \
    ripgrep \
    unzip \
    yt-dlp \
    zip && \
    ostree container commit

# Virtualization packages 
RUN rpm-ostree install -y --allow-inactive \
    libvirt \
    libvirt-daemon-config-network \
    libvirt-daemon-kvm \
    qemu-kvm \
    virt-manager \
    libguestfs-tools \
    python3-libguestfs && \
    ostree container commit

# Wifi packages 
RUN rpm-ostree install -y --allow-inactive \
    NetworkManager       \
    NetworkManager-tui   \
    NetworkManager-wifi  \
    atheros-firmware     \
    b43-fwcutter         \
    b43-openfwwf         \
    brcmfmac-firmware    \
    iwlegacy-firmware    \
    iwlwifi-dvm-firmware \
    iwlwifi-mvm-firmware \
    libertas-firmware    \
    mt7xxx-firmware      \
    nxpwireless-firmware \
    realtek-firmware     \
    tiwilink-firmware    \
    atmel-firmware       \
    zd1211-firmware   && \
    ostree container commit 

# Enable services
RUN systemctl enable libvirtd && \
    systemctl enable plocate-updatedb  && \
    mkdir -p /var/lib/plocate && \
    systemctl enable tailscaled && \
    ostree container commit

## NOTES:
# - /var/lib/alternatives is required to prevent failure with some RPM installs
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit
RUN mkdir -p /var/lib/alternatives && \
    ostree container commit
