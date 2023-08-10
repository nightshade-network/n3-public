{ pkgs, ... }:
{
    username = "kitsu";
    config = {
        description = "Shiroi Kitsu";
        isNormalUser = true;
        extraGroups = ["wheel"];
        openssh.authorizedKeys.keys = [
            "This user does not want their SSH public key released."
        ];
        shell = pkgs.zsh;
    };
    home-manager = {
        home.packages = with pkgs; [
            neofetch
            htop
        ];
    };
}