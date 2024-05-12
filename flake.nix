{
  description = "Neovim environment pinned because the world is on fire";
  inputs = {
    # Use nixos-unstable as nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Wgsl language server
    wgsl_analyzer = {
      url = "github:wgsl-analyzer/wgsl-analyzer";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = { wgsl_analyzer, ... }: {
    homeManagerModules.default = (import ./hm-module.nix) wgsl_analyzer;
  };
}

