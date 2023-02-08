# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  # https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Hibernation_into_swap_file_on_Btrfs
  boot.kernelParams = [ "resume=/swap/swapfile" "resume_offset=269568" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/fdf2e6a0-df54-4aea-b5b4-f0b31a818d18";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/fdf2e6a0-df54-4aea-b5b4-f0b31a818d18";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/fdf2e6a0-df54-4aea-b5b4-f0b31a818d18";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/fdf2e6a0-df54-4aea-b5b4-f0b31a818d18";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C4E6-B929";
      fsType = "vfat";
    };

  # https://nixos.org/manual/nixos/stable/options.html#opt-boot.resumeDevice
  swapDevices = [ { device = "/swap/swapfile"; } ];
  boot.resumeDevice = "/dev/disk/by-uuid/fdf2e6a0-df54-4aea-b5b4-f0b31a818d18";

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
