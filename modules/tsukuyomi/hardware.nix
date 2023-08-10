# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
    imports = [ ];

    boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
    {
        device = "/dev/disk/by-uuid/0e95eea4-9fc9-4038-ae8e-707d15038370";
        fsType = "ext4";
    };

    fileSystems."/boot" =
    {
        device = "/dev/disk/by-uuid/797D-7C72";
        fsType = "vfat";
    };

    swapDevices =
    [
        { device = "/dev/disk/by-uuid/c71fbc06-9f9c-40fe-9be5-ac501ee9d4ed"; }
    ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.eth0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    virtualisation.hypervGuest.enable = true;
}