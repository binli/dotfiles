{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "binli";
  home.homeDirectory = "/home/binli";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".tmux.conf".source = /source/gits/dotfiles/homerc/tmux.conf;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/binli/etc/profile.d/hm-session-vars.sh
  #
  home.sessionPath = [
    "$HOME/bin"
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  dconf.settings = {
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-show-weekday = true;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 0;
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-timeout = 7200;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/console/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/console" = {
      binding = "<Super>Return";
      command = "kgx";
      name = "Console";
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
    };
  };

  programs.git = {
    enable = true;
    userName = "Bin Li";
    userEmail = "binli@ubuntu.com";
    signing = {
      key = "F6FD6C84E7A3C2E8";
      signByDefault = true;
    };
    aliases = {
      st = "status";
    };
  };
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      auto-pairs
      copilot-vim
      vim-dirdiff
      vim-surround
    ];
    settings = {
      backupdir = ["/tmp/vimbk/"];
      expandtab = true;
      mouse = null;
      shiftwidth = 4;
      undodir = ["/tmp/vimbk/"];
    };
    extraConfig = ''
      set encoding=utf-8
      set list listchars=tab:→\ ,trail:·
      let g:DirDiffExcludes = ".bzr,.git,.*.swp,*.in,cscope.*,*~,*.lo"
      if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
      endif
    '';
  };

  programs.bash = {
    enable = true;
    historyControl = ["ignoreboth"];
    shellAliases = {
      e = "exit";
      ".." = "cd ..";
      tmux = "tmux attach";
    };
    sessionVariables = {
      DEBEMAIL="binli@ubuntu.com";
      DEBFULLNAME="Bin Li";
    };
    bashrcExtra =
    ''
        PS1='\[\e[32;1m\]\u\[\e[0m\]@\[\e[34;1m\]\[\e[33;1m\]Ca\[\e[0m\]n\[\e[0m\]\[\e[31;1m\]o\[\e[0m\]\[\e[33;1m\]n\[\e[0m\]\[\e[32;1m\]i\[\e[0m\]\[\e[34;1m\]c\[\e[0m\]\[\e[32;1m\]a\[\e[0m\]\[\e[31;1m\]l\[\e[0m\]:\[\e[34;1m\]\w\[\e[0m\]\[\e[35;1m\]$(__git_ps1)\[\e[0m\]$ '
    '';
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
