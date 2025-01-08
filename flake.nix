{
  description = "ChaosAttractor's NixOS Flake";

  inputs = {
    # Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    # Nix Hardware
    nixos-hardware.url = "github:nixos/nixos-hardware";
    # Disko
    disko.url = "github:nix-community/disko";
    # Impermanence
    impermanence.url = "github:nix-community/impermanence";
    # lanzaboote (Secure boot)
    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    # User Packages
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # NUR Packages
    nur.url = "github:nix-community/NUR";
    # Apple Silicon Support
    apple-silicon-support.url = "github:tpwrules/nixos-apple-silicon";
    apple-silicon-support.inputs.nixpkgs.follows = "nixpkgs";
    # sops-nix
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # AAGL
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
    # Spicetify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    # daeuniverse
    daeuniverse.url = "github:daeuniverse/flake.nix";
    daeuniverse.inputs.nixpkgs.follows = "nixpkgs";
    # xivlauncher-rb
    nixos-xivlauncher-rb.url = "github:drakon64/nixos-xivlauncher-rb";
    nixos-xivlauncher-rb.inputs.nixpkgs.follows = "nixpkgs";
    # vscode-extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
    # flake-programs-sqlite
    flake-programs-sqlite.url = "github:wamserma/flake-programs-sqlite";
    flake-programs-sqlite.inputs.nixpkgs.follows = "nixpkgs";
    # firefox-gnome-theme
    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      user = "lostattractor";
    in
    rec {
      nixosConfigurations = {
        # Zephyrus G14
        CALaptopG14 = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs user system;
          };
          modules = with inputs; [
            ./configuration.nix
            ./platform/desktop
            ./specific/system-specific/CALaptopG14
            ./specific/hardware-specific/asus-zephyrus-ga401
            ./specific/architecture-specific/x86-64
            ./specific/user-specific
            ./lanzaboote.nix
            ./home-manager.nix
            nixos-hardware.nixosModules.asus-zephyrus-ga401
            impermanence.nixosModules.impermanence
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            aagl.nixosModules.default
            daeuniverse.nixosModules.daed
            flake-programs-sqlite.nixosModules.programs-sqlite
            { nixpkgs.config.allowUnfree = true; }
          ];
        };
        CALaptopR9000P = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs user system;
          };
          modules = with inputs; [
            ./configuration.nix
            ./platform/desktop
            ./specific/system-specific/CALaptopR9000P
            ./specific/hardware-specific/lenovo-legion-16ach6h
            ./specific/architecture-specific/x86-64
            ./specific/user-specific
            ./lanzaboote.nix
            ./home-manager.nix
            disko.nixosModules.disko
            nixos-hardware.nixosModules.lenovo-legion-16ach6h  # hardware.nvidia.prime.offload.enable may cause xorg crash
            impermanence.nixosModules.impermanence
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            aagl.nixosModules.default
            daeuniverse.nixosModules.daed
            flake-programs-sqlite.nixosModules.programs-sqlite
            { nixpkgs.config.allowUnfree = true; }
          ];
        };
        # CAAppleSilicon
        CAAppleSilicon = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs user system;
          };
          modules = with inputs; [
            ./configuration.nix
            ./platform/desktop
            ./specific/system-specific/CAAppleSilicon
            ./specific/hardware-specific/apple-silicon
            ./specific/user-specific
            apple-silicon-support.nixosModules.apple-silicon-support
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
          ];
        };
      };
      hydraJobs.nixosConfigurations = nixpkgs.lib.mapAttrs' (
        name: config: nixpkgs.lib.nameValuePair name config.config.system.build.toplevel
      ) nixosConfigurations;
    };
}
