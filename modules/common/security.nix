{ pkgs, config, ... }:
{
    security.sudo.wheelNeedsPassword = false;
    security.acme.acceptTerms = true;
    security.acme.defaults.email = "admin@nightshade.network";
}