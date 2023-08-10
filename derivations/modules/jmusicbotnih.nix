{ lib, config, pkgs ? import <nixpkgs> {}, ... }:
with lib;
with pkgs;
let
    pkg = callPackage ../pkgs/jmusicbotnih.nix {};
    cfg = config.services.jmusicbotnih;
    configFile = pkgs.writeText "config.txt" ''
        token = ${cfg.token}
        owner = ${cfg.owner}
        prefix = "${cfg.prefix}"
    '';
in
{
    options = {
        services.jmusicbotnih = {
            enable = mkEnableOption "JMusicBot";
    
            token = mkOption {
                default = "";
                type = types.str;
                description = mdDoc "Discord bot token";
            };

            owner = mkOption {
                default = "";
                type = types.str;
                description = mdDoc "Discord owner ID (as string to prevent int weirdness)";
            };

            prefix = mkOption {
                default = "!";
                type = types.str;
                description = mdDoc "Command prefix";
            };
        };
    };

    config = {
        systemd.services.jmusicbot = mkIf cfg.enable {
            description = "JMusicBot";

            serviceConfig = {
                Type = "simple";
                TimeoutStartSec = 0;
                ExecStart = "${pkg}/bin/jmusicbot";
                WorkingDirectory = "/var/lib/jmusicbot";
                Restart = "always";
                RestartSec = "5s";
            };

            unitConfig = {
                StartLimitIntervalSec = "500";
                StartLimitBurst = "5";
            };

            preStart = ''
                if [ ! -d /var/lib/jmusicbot ]; then
                    mkdir /var/lib/jmusicbot
                fi

                cp ${configFile} /var/lib/jmusicbot/config
            '';

            wants = [ "network-online.target" ];
            after = [ "network-online.target" ];
            wantedBy = [ "multi-user.target" ];
        };
    };
}