# dotfiles
Config files for hyprland and related tools as well as the configuration.nix

If doing a fresh install, make two partitions.
1st is a 512M fat32 partition
```bash
mkfs.vfat -F32 /dev/sdX1
```
2nd is the rest of the drive in btrfs
```bash
mkfs.btrfs /dev/sdX2
```

Mount the 2nd partition to /mnt
```bash
mount /dev/sdX2 /mnt
```

Then create the subvolumes for the second partition
```bash
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
```

Unmount the 2nd partition
```bash
umount /mnt
```

Mount the root subvolume using
```bash
mount -o compress=zstd,subvol=root /dev/sdX2 /mnt
```
Then create the partitions needed to mount the other two and then mount them
```bash
mkdir /mnt/{home,nix}
mount -o compress=zstd,subvol=home /dev/sdX2 /mnt/home
mount -o compress=zstd,noatime,subvol=nix /dev/sdX2 /mnt/nix
```

Mount the boot partition
```bash
mkdir /mnt/boot
mount /dev/sdX1 /mnt/boot
```

Then generate a default Nix config and hardware config
```bash
nixos-generate-config --root /mnt
```

Edit the liveISO NixOS config and add 'git' or obtain git some other way.
Then clone this repo and place the configuration.nix file into /mnt/etc/nixos/configuration.nix.
Edit if necessary.

Finally, run
```bash
nixos-install
```

Reboot and clone the repo again, then use the install script
```bash
git clone https://github.com/cosmicelijah/dotfiles/
cd dotfiles/
sudo ./install.sh
```

Run a nixos rebuild then reboot
```
sudo nixos-rebuild switch
```
