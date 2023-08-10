{ config, pkgs, ... }:
{
    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Enable unfree pkgs
    nixpkgs.config.allowUnfree = true;
}