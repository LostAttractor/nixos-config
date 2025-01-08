_:
{
  # Use systemd-cryptenroll to auto unlock luks partition
  boot.initrd.systemd.enable = true;
  security.tpm2.enable = true;
  security.tpm2.tctiEnvironment.enable = true;

  # security.tpm2.pkcs11.enable = true;
  # security.tpm2.pkcs11.package = pkgs.tpm2-pkcs11.override { abrmdSupport = false; }; # Using Kernel RM

  # environment.systemPackages = with pkgs; [
  #   (tpm2-tools.override { abrmdSupport = false; })
  #   tpm2-tss
  # ];
}