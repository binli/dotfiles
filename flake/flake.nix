{
  description = "BinLi's Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #bughamster = {
    #  url = "git+ssh://git@github.com/canonical/bughamster?ref=jira-nix";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    # Home computer, P1 Gen 6, cc15
    nixosConfigurations.raccoon = nixpkgs-unstable.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./cc15-configuration.nix
        inputs.home-manager-unstable.nixosModules.home-manager
        {
          #home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.binli = ./home.nix;
        }
      ];
    };
    # Home computer, P1 Gen 7
    nixosConfigurations.Raccoon = nixpkgs-unstable.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./office-configuration.nix
        inputs.home-manager-unstable.nixosModules.home-manager
        {
          #home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.binli = ./home.nix;
        }
      ];
    };
    # HP computer
    nixosConfigurations.warthog = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./warthog-configuration.nix
        inputs.home-manager.nixosModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.binli = ./home.nix;
        }
      ];
    };
  };
}
