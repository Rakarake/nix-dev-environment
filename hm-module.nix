{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.dev-stuff;
in
{
  # Option to enable dev-stuff
  options.dev-stuff = {
    # Option to enable Hyprland config
    enable = lib.mkEnableOption "Programming environment";
  };

  config = lib.mkIf cfg.enable {
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
  };
}
