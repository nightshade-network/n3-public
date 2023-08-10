{ pkgs, ... }:
let
    deploymentKey = ../../files/deployment_key;
in
{
    systemd.services.nn-landing = {
        description = "Pull down the nightshade.network landing page";

        restartIfChanged = true;

        serviceConfig.type = "oneshot";
        serviceConfig.TimeoutStartSec = 0;

        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];

        path = with pkgs; [ gitMinimal openssh coreutils ];

        script = ''

            if [ ! -d /var/www ]; then
                mkdir /var/www
            fi

            cp ${deploymentKey} /tmp/git-ssh-key
            chmod 600 /tmp/git-ssh-key

            export GIT_SSH_COMMAND="${pkgs.openssh}/bin/ssh -i /tmp/git-ssh-key -o StrictHostKeyChecking=no"

            trap 'rm -f /tmp/git-ssh-key' EXIT

            if [ -d /var/www/landing ]; then
                cd /var/www/landing
                ${pkgs.gitMinimal}/bin/git pull
            else
                mkdir /var/www/landing
                cd /var/www/landing
                ${pkgs.gitMinimal}/bin/git clone git@github.com:nightshade-network/landing.git .
            fi

            unset GIT_SSH_COMMAND

        '';
    };

    system.activationScripts = {
        update_landing = {
            text = ''
                echo nn-landing > /run/nixos/activation-restart-list
            '';
        };
    };
}