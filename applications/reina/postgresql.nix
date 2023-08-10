{ config, pkgs, ... }:
{
    services.postgresql = {
        enable = true;
        package = pkgs.postgresql_15;
        dataDir = "/mnt/database/psql-data";
        enableTCPIP = false;
    };
}