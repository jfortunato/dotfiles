{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-INTEL_SSDPEKKF256G8L_BTHH814611S0256B";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              # Default start value aligns properly for this drive to start at sector 2048 (1M)
              #
              # Parted can calculate the optimal alignment for via (careful) `parted /dev/nvme0n1 mkpart primary ext4 0% 100%`,
              # then check with `fdisk -l /dev/nvme0n1` and note the Start value.
              # Check alignment with `parted /dev/nvme0n1 align-check optimal 1`
              # https://wiki.archlinux.org/title/Parted#Alignment
              #start = "1M";
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
    };
    zpool = {
      rpool = {
        type = "zpool";
        options = {
          ashift = "12";
        };
        rootFsOptions = {
          canmount = "off";
          mountpoint = "none";
          compression = "zstd";
          acltype = "posixacl";
          xattr = "sa";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "file:///tmp/secret.key";
        };
        # use this to read the key during boot
        postCreateHook = ''
          zfs list -t snapshot -H -o name | grep -E '^rpool@blank$' || zfs snapshot rpool@blank;
          zfs set keylocation="prompt" rpool;
        '';

        datasets = {
          root = {
            type = "zfs_fs";
            options = {
              canmount = "noauto";
              mountpoint = "legacy";
            };
            mountpoint = "/";
          };
          nix = {
            type = "zfs_fs";
            options = {
              canmount = "noauto";
              mountpoint = "legacy";
            };
            mountpoint = "/nix";
          };
          var = {
            type = "zfs_fs";
            options = {
              canmount = "noauto";
              mountpoint = "legacy";
            };
            mountpoint = "/var";
          };
          home = {
            type = "zfs_fs";
            options = {
              canmount = "noauto";
              mountpoint = "legacy";
            };
            mountpoint = "/home";
          };
        };
      };
    };
  };
}
