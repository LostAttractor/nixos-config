{ config, pkgs, ... }:
{
    users.users.chaosattractor = {
        packages = with pkgs; [
            # osu-lazer #体验很差
        ];
    };
    imports = [
        ./steam.nix
    ];
}