{
  description = "Neovim environment pinned because the world is on fire";
  inputs = {
    # Use nixos-unstable as nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { ... }: {
    homeManagerModules.default = import ./hm-module.nix;
  };
}

