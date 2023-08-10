{ config, pkgs, ... }:
{
    services.nginx.enable = true;

    users.users.nginx.extraGroups = ["acme"];

    services.nginx.virtualHosts = {
        "jellyfin.nightshade.network" = {
            enableACME = true;
            forceSSL = true;

            locations."/" = {
                proxyPass = "http://alexander:8096";
                proxyWebsockets = true;
                extraConfig = "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;";
            };
        };

        "hass.nightshade.network" = {
            enableACME = true;
            forceSSL = true;

            locations."/" = {
                proxyPass = "http://hephaistos:8123";
                proxyWebsockets = true;
                extraConfig = "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;";
            };
        };

        "git.nightshade.network" = {
            enableACME = true;
            forceSSL = true;

            locations."/" = {
                proxyPass = "http://twintania:3200";
                proxyWebsockets = true;
                extraConfig = "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;";
            };
        };

        "nightshade.network" = {
            enableACME = true;
            forceSSL = true;

            locations = {
                "/" = {
                    root = "/var/www/landing";
                };
                "/plogon" = {
                    root = "/var/www";
                };
            };
        };
    };
}
