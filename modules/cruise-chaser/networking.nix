{ lib, config, pkgs, ... }:
{
    networking.hostName = "cruise-chaser";
    networking.domain = "";

    networking.firewall = {
        enable = true;

        allowedTCPPorts = lib.mkForce [ 80 443 ];

        interfaces."ens3" = {
            allowedTCPPorts = [ 80 443 ];
        };

        # Let *everything* through on tailscale0
        trustedInterfaces = ["tailscale0"];
    };

    networking.firewall.checkReversePath = "loose";

    # Attempt to enable IPv6 router administration
    networking.dhcpcd.IPv6rs = true;
}