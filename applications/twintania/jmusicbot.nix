{ config, pkgs, ... }:
{
    services.jmusicbotnih = {
        enable = true;
        token = "REDACTED";
        owner = "190544080164487168";
        prefix = "-";
    };
}