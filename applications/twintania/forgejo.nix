{ config, pkgs, ... }:
{
    users.users.git = {
        description = "Forgejo";
        home = "/var/lib/gitea";
        useDefaultShell = true;
        group = "git";
        isSystemUser = true;
    };

    users.groups.git = {};

    services.gitea = {
        enable = true;

        package = pkgs.forgejo;

        lfs.enable = true;
        
        appName = "Nightshade Network Forgejo";

        user = "git";
        database.user = "git";
        
        settings.server = {
            SSH_DOMAIN = "twintania.nightshade.network";
            HTTP_PORT = 3200;
            ROOT_URL = "https://git.nightshade.network/";
            DOMAIN = "git.nightshade.network";
        };

        settings.service.DISABLE_REGISTRATION = true;

        # TODO... but I haven't needed to yet.
        settings.mailer = {
            ENABLED = false;
        };
    };
}
