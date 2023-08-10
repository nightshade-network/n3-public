args@{ self, lib, config, pkgs, hostname, ... }:
with lib;
with builtins;
let
    commonUserPaths = map (x: "${self}/users/common/${x}") (attrNames (readDir ./users/common));
    hostUserPaths = map (y: "${self}/users/${hostname}/" + y) (attrNames (readDir ("${self}/users/${hostname}")));
    userPaths = commonUserPaths ++ hostUserPaths;

    userTable = map (x: import x args) userPaths;
    userList = listToAttrs (map (set: {name = set.username; value = set.config;}) userTable);
    homeManagerConfig = listToAttrs (map (set: {
        name = set.username;
        value = set.home-manager // {
            home = {stateVersion = "22.11";} // set.home-manager.home;
        };
    }) userTable);

    modifyDate = concatStringsSep "/" (match "(.{4})(.{2})(.{2}).*" self.lastModifiedDate);
in
{
    users.users = userList;
    home-manager.users = homeManagerConfig;

    users.motd = ''

< welcome to ${hostname}! >

this computer is powered by n3 ver ${self.sourceInfo.shortRev} (${modifyDate})
(NixOS ver ${config.system.nixos.version} '${config.system.nixos.codeName}')

https://git.nightshade.network/nn/n3

    '';
}