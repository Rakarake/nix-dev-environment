wgsl_analyzer: {
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dev-stuff;
in
{
  imports = [
    ./bash.nix
  ];
  # Option to enable dev-stuff
  options.dev-stuff = {
    # Option to enable Hyprland config
    enable = lib.mkEnableOption "Programming environment";
  };

  config = lib.mkIf cfg.enable {
    # Direnv
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Generic shell options
    home.file.".alias".source = ./.alias;
    # Bash config
    home-bash.enable = true;
    # ZSH config
    home.file.".zshrc".source = ./.zshrc;

    # Kitty config
    home.file.".config/kitty/kitty.conf".source = ./kitty/kitty.conf;
    home.file.".config/kitty/Catppuccin-Macchiato.conf".source = ./kitty/Catppuccin-Macchiato.conf;
    # Ghci prompt
    home.file.".ghci".source = ./.ghci;

    # Git config
    programs.git = {
      enable = true;
      lfs.enable = true;
      userName  = "Rakarake";
      userEmail = "rak@rakarake.xyz";
      extraConfig = {
        core = {
          editor = "nvim";
        };
        color = {
          ui = "auto";
        };
        user = {
          signingKey = "98CF6C24F40B3531!";
        };
      };
    };

    # Neovim config
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        plenary-nvim
        telescope-nvim
        catppuccin-nvim  # Theme
        toggleterm-nvim
        vimwiki
        typst-vim
        # LSP
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        luasnip
      ];
    };
    # Make sure undodir exists
    home.file.".config/nvim/undodir/gamnangstyle".text = "whop\n";
    # Neovim main configuration file
    home.file.".config/nvim/init.lua".source = ./nvim/init.lua;
    # Neovim filetype specific configs
    home.file.".config/nvim/ftplugin/gdscript.lua".source = ./nvim/ftplugin/gdscript.lua;
    home.file.".config/nvim/ftplugin/html.lua".source = ./nvim/ftplugin/html.lua;

    # Programming packages
    home.packages = (with pkgs; [
      vscode

      # HTML / CSS / JSON / ESLint language server
      vscode-langservers-extracted

      # C / C++
      ccls          # A C/C++ language server

      # Haskell
      haskell-language-server

      # Nix??? 😲
      nil  # Nix language server

      # Godot
      godot_4

      # Rust
      cargo
      rust-analyzer # Rust language server

      # Lua
      lua-language-server

      # Go
      gopls

      # Typst
      typst-lsp

      # WGSL
      wgsl_analyzer.packages.${system}.default

      # C#
      csharp-ls
    ]);

    # Godot single single window
    xdg.desktopEntries.godotOneWindow = {
      name = "Godot 4 Single Window";
      genericName = "Godot 4 Single Window";
      exec = "godot4 --single-window";
    };
  };
}
