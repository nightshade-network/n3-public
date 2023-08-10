{ config, pkgs, ... }:
{
    networking.hostName = "tsukuyomi";
    
    networking.firewall.enable = false;
}