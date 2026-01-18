#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

COMMAND="${1:-}"

function yesno() {
    local prompt="$1"
    while true; do
        read -rp "$prompt [y/n] " yn
        case $yn in
            [Yy]* ) echo "y"; return;;
            [Nn]* ) echo "n"; return;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

STATE_FILE="$HOME/kickstart.json"
if [[ ! -f "$STATE_FILE" || ! -s "$STATE_FILE" ]]; then
    echo '{}' > "$STATE_FILE"
fi

function kv_set() {
    local key="$1"
    local value="$2"

    jq --arg k "$key" --arg v "$value" \
        '.[$k] = $v' "$STATE_FILE" > "${STATE_FILE}.tmp" \
        && mv "${STATE_FILE}.tmp" "$STATE_FILE"
}

function kv_get() {
    local key="$1"
    jq -r --arg k "$key" '.[$k] // empty' "$STATE_FILE"
}

if [[ "$COMMAND" == "edit" ]]; then
    kv_set "IS_PRE_FORMAT" "true"
    cat << Edit
    This option allows you to copy down your own forked kickstart repository, or copy down the main kickstart
    repository to then make your own edits. If you want you can also fork it using the included browser and pull that down.
    You can also provide your own name for the folder. This folder will live in your home directory under that name.
Edit
    read -rp "Enter local config name (default:nixos-kickstart): " local_name
    local_name="${local_name:-nixos-kickstart}"
    kv_set "LOCAL_NAME" "$local_name"
    kv_set "CONFIG_DIR" "$PWD/$local_name"
    kv_set "CONFIG_MARKER" "$(kv_get CONFIG_DIR)/.kickstart-cloned"
    read -rp "Enter repo URL (default: github.com/argosnothing/nixos-kickstart): " repo
    kv_set "REPO" "${repo:-github.com/argosnothing/nixos-kickstart}"
    read -rp "Enter git branch/rev (default: main): " git_rev
    kv_set "GIT_REV" "${git_rev:-main}"

    if [[ -d "$(kv_get CONFIG_DIR)" ]]; then
        overwrite=$(yesno "Directory $(kv_get CONFIG_DIR) already exists. Overwrite?")
        if [[ $overwrite == "y" ]]; then
            rm -rf "$(kv_get CONFIG_DIR)"
        else
            exit 0
        fi
    fi

    read -rp "Enter username (default: kickster) " username
    username="${username:-kickster}"
    kv_set "USERNAME" "$username"

    if [[ "$username" != "kickster" ]]; then
    cat << USER_INFO
You will need to go into modules/+username.nix and change the username value to $username
USER_INFO
    fi

    read -rp "Enter hostname (default: starter) " hostname
    hostname="${hostname:-starter}"
    kv_set "HOSTNAME" "$hostname"
    if [[ "$hostname" != "starter" ]]; then
        cat << HOST_INFO
        You will need to go into modules/nixos-host.nix and modules/nixosConfigurations and swap
        starter for $hostname. Also while you're in nixos-host.nix you can swap firmware modules if needed.
HOST_INFO
    fi

    echo "Cloning $(kv_get REPO) ($(kv_get GIT_REV))..."
    nix-shell -p git --run "git clone https://$(kv_get REPO).git $(kv_get CONFIG_DIR)"
    cd "$(kv_get CONFIG_DIR)"
    nix-shell -p git --run "git checkout $(kv_get GIT_REV)"
    touch "$(kv_get CONFIG_MARKER)"
    cat << NEXT_STEPS

    Repository cloned to $(kv_get CONFIG_DIR)

  Edit your configuration:
  cd $(kv_get CONFIG_DIR)
  vim modules/+username.nix
  vim modules/+nixos-host.nix

  Also edit nixos-host and nixosConfigurations, you'll wanting to replace 'starter' with your host name. Also
  If you're using UEFI you'll want to use that module in nixos-host instead of the default grub one.

When ready to install:
  kickstart install

NEXT_STEPS
    exit 0
fi

if [[ "$COMMAND" == "install" ]]; then
    if [[ -f "$(kv_get CONFIG_MARKER)" ]]; then
        echo "Using local configuration from $(kv_get CONFIG_DIR)"
        FLAKE_PATH="$(kv_get CONFIG_DIR)"
        USE_LOCAL=true
    else
        read -rp "Enter flake URL (default: github:argosnothing/nixos-kickstart): " repo
        repo="${repo:-github:argosnothing/nixos-kickstart}"
        FLAKE_PATH="$repo"
        USE_LOCAL=false
    fi

    if [[ "$(kv_get IS_PRE_FORMAT)" == "true" ]]; then
    cat << Introduction
The *entire* disk will be formatted with a 1GB boot partition
(labelled NIXBOOT), 16GB of swap, and the rest allocated to ZFS.

The following ZFS datasets will be created:
    - zroot/root (mounted at / with blank snapshot)
    - zroot/nix (mounted at /nix)
    - zroot/tmp (mounted at /tmp)
    - zroot/persist (mounted at /persist)
    - zroot/cache (mounted at /cache)

** IMPORTANT **
This script assumes that the relevant "fileSystems" are declared within the
NixOS config to be installed. It does not create any hardware configuration
or modify the NixOS config to be installed in any way. If you have not done
so, you will need to add the necessary zfs options and filesystems before
proceeding or your install WILL NOT BOOT.

Introduction

    if [[ -b "/dev/vda" ]]; then
        DISK="/dev/vda"
    else
        lsblk
        mapfile -t disks < <(lsblk -ndo NAME,SIZE,MODEL)
        echo -e "\nAvailable disks:\n"
        for i in "${!disks[@]}"; do
            printf "%d) %s\n" $((i+1)) "${disks[i]}"
        done
        while true; do
            echo ""
            read -rp "Enter the number of the disk to install to: " selection
            if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#disks[@]} ]; then
                break
            else
                echo "Invalid selection. Please try again."
            fi
        done
        DISK="/dev/$(echo "${disks[$selection-1]}" | awk '{print $1}')"
    fi

    if [[ "$DISK" =~ "nvme" ]]; then
        BOOTDISK="${DISK}p3"
        SWAPDISK="${DISK}p2"
        ZFSDISK="${DISK}p1"
    else
        BOOTDISK="${DISK}3"
        SWAPDISK="${DISK}2"
        ZFSDISK="${DISK}1"
    fi

    echo "Boot Partition: $BOOTDISK"
    echo "SWAP Partition: $SWAPDISK"
    echo "ZFS Partition: $ZFSDISK"
    echo ""

    do_format=$(yesno "This irreversibly formats the entire disk. Are you sure?")
    if [[ $do_format == "n" ]]; then
        exit
    fi

    echo "Creating partitions"
    sudo blkdiscard -f "$DISK"
    sudo sgdisk --clear "$DISK"
    sudo sgdisk -n3:1M:+1G -t3:EF00 "$DISK"
    sudo sgdisk -n2:0:+16G -t2:8200 "$DISK"
    sudo sgdisk -n1:0:0 -t1:BF01 "$DISK"
    sudo sgdisk -p "$DISK" > /dev/null
    sleep 5

    echo "Creating Swap"
    sudo mkswap "$SWAPDISK" --label "SWAP"
    sudo swapon "$SWAPDISK"

    echo "Creating Boot Disk"
    sudo mkfs.fat -F 32 "$BOOTDISK" -n NIXBOOT

    encryption_options=()
    echo "Creating base zpool"
    sudo zpool create -f \
        -o ashift=12 \
        -o autotrim=on \
        -O compression=zstd \
        -O acltype=posixacl \
        -O atime=off \
        -O xattr=sa \
        -O normalization=formD \
        -O mountpoint=none \
        "${encryption_options[@]}" \
        zroot "$ZFSDISK"

    echo "Creating /"
    sudo zfs create -o mountpoint=legacy zroot/root
    sudo zfs snapshot zroot/root@blank
    sudo mount -t zfs zroot/root /mnt

    echo "Mounting /boot (efi)"
    sudo mount --mkdir "$BOOTDISK" /mnt/boot

    echo "Creating /nix"
    sudo zfs create -o mountpoint=legacy zroot/nix
    sudo mount --mkdir -t zfs zroot/nix /mnt/nix

    echo "Creating /tmp"
    sudo zfs create -o mountpoint=legacy zroot/tmp
    sudo mount --mkdir -t zfs zroot/tmp /mnt/tmp

    echo "Creating /cache"
    sudo zfs create -o mountpoint=legacy zroot/cache
    sudo mount --mkdir -t zfs zroot/cache /mnt/cache

    restore_snapshot=$(yesno "Do you want to restore from a persist snapshot?")
    if [[ $restore_snapshot == "y" ]]; then
        echo "Enter full path to snapshot: "
        read -r snapshot_file_path
        echo
        echo "Creating /persist"
        sudo sh -c "zfs receive -o mountpoint=legacy zroot/persist < '$snapshot_file_path'"
    else
        echo "Creating /persist"
        sudo zfs create -o mountpoint=legacy zroot/persist
    fi
    sudo mount --mkdir -t zfs zroot/persist /mnt/persist
    kv_set "IS_PRE_FORMAT" "false"
fi

    if [[ $USE_LOCAL == false ]]; then
        read -rp "Enter git rev for flake (default: main): " git_rev
        FLAKE_REF="$FLAKE_PATH/${git_rev:-main}#host"
    else
        host="$(kv_get HOSTNAME)"
        FLAKE_REF="$FLAKE_PATH#$host"
    fi

    username="$(whoami)"

    echo "Staging age key into target /persist before install (for sops-nix)..."
    source_age_key="${HOME}/.config/sops/age/keys.txt"
    target_age_key="/mnt/persist/home/$username/.config/sops/age/keys.txt"

    if [[ -f "$source_age_key" ]]; then
        sudo install -d -m700 "$(dirname "$target_age_key")"
        sudo install -m600 "$source_age_key" "$target_age_key"
        sudo chown -R "$username" "/mnt/persist/home/$username/.config/sops"
    else
        echo "WARNING: Could not locate $source_age_key; sops secrets may fail during install."
        echo "         Put your key at $target_age_key before reboot, or adjust your sops config."
    fi

    echo "Installing NixOS"
    sudo nixos-install --flake "$FLAKE_REF" --option tarball-ttl 0

    echo "Copying configuration to installed system..."
    sudo mkdir -p "/mnt/persist/home/$username/nixos-config"
    sudo cp -a "$HOME/nixos-config/." "/mnt/persist/home/$username/nixos-config/"

    if sudo chroot /mnt /bin/sh -c "id -u '$username' >/dev/null 2>&1"; then
        sudo chroot /mnt /bin/sh -c "grp=\$(id -gn '$username' 2>/dev/null || echo users); chown -R '$username':\"\$grp\" /persist/home/'$username' || chown -R '$username' /persist/home/'$username'"
    else
        sudo chown -R "$username" "/mnt/persist/home/$username"
    fi

    echo "Installation complete. It is now safe to reboot."
    exit 0
fi

echo "Usage: kickstart [edit|install]"
echo ""
echo "  edit    - Clone config repo for customization"
echo "  install - Install NixOS (uses local config if available)"
exit 1
