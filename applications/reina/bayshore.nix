{ config, pkgs, ... }:
{
    services.bayshore = {
        enable = true;
        postgresUrl = "postgres://bayshore:DATABASE_PASSWORD_REDACTED@localhost:5432/bayshore";
        configFile = "/var/lib/bayshore/config.json";
    };
}