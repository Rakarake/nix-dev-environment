{
  description = "Rakarake's dev environment/stuff";
  inputs = {
    # Use nixos-unstable as nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    wgsl_analyzer.url = "github:wgsl-analyzer/wgsl-analyzer";
  };
  outputs = { wgsl_analyzer, ... }: {
    homeManagerModules.default = import ./hm-module.nix wgsl_analyzer;
  };
}

