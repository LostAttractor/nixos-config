_: {
  environment.persistence."/persistent" = {
    hideMounts = true;

    directories = [
      "/etc/secureboot"
      "/etc/NetworkManager/system-connections"
      "/etc/daed"
      "/etc/asusd"
      "/var/lib"
      "/var/log"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
    ];
  };
}
