{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    epiphany # web browser
  ]);

  # Enable Wayland for Chromium (CEF) Apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Fix that some apps cannot open links
  xdg.portal.xdgOpenUsePortal = true; 

  # Enable Firewall for Gnome Remote Display
  networking.firewall.allowedTCPPorts = [ 3389 ];
}
