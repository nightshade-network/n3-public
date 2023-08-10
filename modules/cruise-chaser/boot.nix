{ config, pkgs, ... }:
{
    boot.tmp.cleanOnBoot = true;
    zramSwap.enable = true;
}