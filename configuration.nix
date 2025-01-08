# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ lib, pkgs, ... }:

{
  imports = [
    # modules/basic
    ./modules/time.nix
    ./modules/network.nix
    ./modules/ssh.nix
    ./modules/shell.nix
    ./modules/nix.nix
    # modules/features
    ./modules/features/virtualisation.nix
    ./modules/features/docker.nix
    ./modules/features/filesystems.nix
    ./modules/features/fwupd.nix
    ./modules/features/pcscd.nix
    ./modules/features/appimage.nix
    ./modules/features/nix-ld.nix
    # secrets
    ./secrets
    # package
    ./packages
    ./packages/gaming.nix
    # user config
    ./user
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = lib.mkDefault "auto";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 180;
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;

  # Using Tmpfs for /tmp to speed up the system
  # If you have less memory, this can cause Nix builds to fail
  boot.tmp.useTmpfs = true;
  # You can choose whether to clean /tmp on boot, but this is not necessary for Tmpfs
  # boot.tmp.cleanOnBoot = true;

  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;
  nixpkgs.overlays = [
    (final: prev: {
      mutter = prev.mutter.overrideAttrs (oldAttrs: {
        patches = oldAttrs.patches or [ ] ++ [
          ./wayland-text-input-v1-Implement-basic-text-input-v1-.patch
        ];
      });
    })
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
