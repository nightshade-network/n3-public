{
    description = "nightshade network nixos";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        vscode-server.url = "github:nix-community/nixos-vscode-server";
        home-manager.url = "github:nix-community/home-manager";
        bayshore.url = "github:ProjectAsakura/Bayshore";
    };

    inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
    inputs.vscode-server.inputs.nixpkgs.follows = "nixpkgs";
  
    outputs = inputs@{ self, nixpkgs, vscode-server, home-manager, bayshore }:
    with builtins;
    let
        commonModList = map (x: "${self}/modules/common/${x}") (attrNames (readDir ./modules/common));
        commonModules = commonModList ++ [ ./users.nix ];

        mkModList = x: map (y: "${self}/modules/${x}/" + y) (attrNames (readDir ("${self}/modules/${x}")));
        mkAppList = x: if pathExists "${self}/applications/${x}/" then
            map (y: "${self}/applications/${x}/" + y) (attrNames (readDir ("${self}/applications/${x}")))
        else
            [];

        mkLoadList = x: (mkModList x) ++ (mkAppList x);
    in
    with builtins;
    {
        # tsukuyomi
        nixosConfigurations."tsukuyomi" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
                vscode-server.nixosModule
                home-manager.nixosModules.home-manager
            ] ++ commonModules ++ (mkLoadList "tsukuyomi");
            specialArgs = {
                inherit self;
                hostname = "tsukuyomi";
            };
        };

        # cruise-chaser
        nixosConfigurations."cruise-chaser" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager
            ] ++ commonModules ++ (mkLoadList "cruise-chaser");
            specialArgs = {
                inherit self;
                hostname = "cruise-chaser";
            };
        };

        # twintania
        nixosConfigurations."twintania" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager
                ./derivations/modules/jmusicbotnih.nix
            ] ++ commonModules ++ (mkLoadList "twintania");
            specialArgs = {
                inherit self;
                hostname = "twintania";
            };
        };

        # reina
        nixosConfigurations."reina" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager
                bayshore.nixosModule
            ] ++ commonModules ++ (mkLoadList "reina");
            specialArgs = {
                inherit self;
                hostname = "reina";
            };
        };
    };
}
