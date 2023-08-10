{ pkgs, ... }:
{
    username = "root";
    config = {
        openssh.authorizedKeys.keys = [
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLMef6lN0zSadPO/IrsHqPM4lYA4dvSF7zC7CQL+XH1eox3Sonrxdlq25fHYUIMosSMEuose4mawx2kREBBvGajNznpUEnkW64l1KYjQUYa1jHhmeWRXH5gciO5m65YeriRDvU9Dv4rxhEr0oTcZ3P/FClxss61Je+4mKXpw+WKUoor68WnJB0wvbhP1y0oDAxTfZ5udCJi+tegSZr2WGa0kWdLoPtJeQ8DVJGmg3gOCL4RzeIIuHtQ81b+NMnS+8uTSfVtaENsbk34lTBrKqMRB9C/R53srw70mFAB8oscwmDUd8x+Wn0ukax2i/dFtO1mPLRF4jDqQqRbBg+8X76pkUCkRQGOxageokVsyh3DQZ4Ron/RIGBRNH1iphi70rJlfnTEBaB3kQEnRrmvsZquHHLeQdTMBGHFH+tqO/wqW1GgDwwKEu6TgpyGYmXQN45wJ49lSXC2tN4KNAkKUvNe47hEhjv0N0+s36i8FsxZPj40eWaOlhuotUOFB1wF7E= main"
        ];
    };
    home-manager = {
        home.packages = with pkgs; [
            neofetch
            htop
        ];

        programs.git = {
            enable = true;
            userName = "Deployment Service";
            userEmail = "deployment@nightshade.network";
        };
    };
}