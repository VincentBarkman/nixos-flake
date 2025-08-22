{
  description = "Reproducible NixOS + Home Manager setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.atlas = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/atlas/hardware-configuration.nix  
          ./hosts/atlas/system.nix

          home-manager.nixosModules.home-manager {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vincent = import ./home/vincent.nix;
          }
        ];
        
      };
    };
}
