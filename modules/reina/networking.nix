{ lib, config, pkgs, ... }:
{
    networking.hostName = "reina";
    networking.domain = "";

    networking.firewall = {
        enable = true;

        # External SSH access here is enabled to make Kitsu not have to DL Tailscale
        allowedTCPPorts = lib.mkForce [ 80 443 10082 9002 9003 22 ];

        interfaces."ens3" = {
            allowedTCPPorts = [ 80 443 10082 9002 9003 22 ];
        };

        # Let *everything* through on tailscale0
        trustedInterfaces = ["tailscale0"];
    };

    networking.firewall.checkReversePath = "loose";
}