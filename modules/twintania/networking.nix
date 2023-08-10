{ lib, config, pkgs, ... }:
{
    networking.hostName = "twintania";
    networking.domain = "contaboserver.net";

    networking.firewall = {
        enable = true;

        # 22 only open for the purposes of forgejo (see applications/twintania/forgejo.nix)
        allowedTCPPorts = lib.mkForce [ 80 443 22 ];

        # Let *everything* through on tailscale0
        trustedInterfaces = ["tailscale0"];
    };

    networking.firewall.checkReversePath = "loose";
}