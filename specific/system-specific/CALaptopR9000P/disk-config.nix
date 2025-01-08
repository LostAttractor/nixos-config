_:
{
    fileSystems."/" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=755" ];
  };

  fileSystems."/persistent".neededForBoot = true;

  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/nvme0n1";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        luks = {
          end = "-32G";
          content = {
            type = "luks";
            name = "crypted";
            passwordFile = "/tmp/secret.key"; # Interactive
            settings.allowDiscards = true;
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/persistent" = {
                  mountpoint = "/persistent";
                  mountOptions = [ "compress=zstd" "discard=async" ];
                };
                "/root" = {
                  mountpoint = "/root";
                  mountOptions = [ "compress=zstd" "discard=async" ];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" "discard=async" ];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "discard=async" "noatime" ];
                };
              };
            };
          };
        };
        encryptedSwap = {
          size = "100%";
          content = {
            type = "swap";
            randomEncryption = true;
            discardPolicy = "both";
          };
        };
      };
    };
  };
}