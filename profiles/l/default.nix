{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./cli/mpv # Media player
    ./cli/micro # Text editor
    ./cli/vscodium
    ./cli/kitty # Terminal emulator
    ./cli/fish.nix # Shell
    ./cli/git.nix
    ./cli/lazygit.nix
    ./cli/spicetify.nix # Spotify
    ./cli/yazi.nix # File browser

    ./desktop/vivaldi.nix
    ./desktop/obsidian.nix # Notes (.md)
    ./desktop/sioyek.nix # PDF
    ./desktop/discord.nix
    ./desktop/gnome.nix
    ./desktop/flatpak.nix
    ./desktop/obs.nix

    ./services/picom # Compositor
    ./services/opensnitch.nix # Firewall
    ./services/espanso.nix # Text expander
    ./services/ulauncher.nix # App launcher
    ./services/syncthing.nix
    ./services/flameshot.nix # Screenshot
    ./services/xbanish.nix # Hide mouse on input
    ./services/sxhkd.nix # Keybind -> shell cmd
  ];

  config = {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = [ inputs.rust-overlay.overlays.default ];
    };

    home = {
      username = "l";
      homeDirectory = "/home/l";
      stateVersion = "22.11";
    };

    home.packages = builtins.attrValues {

      # CLI
      inherit (pkgs)
        ripgrep # `grep` alt.
        grex # Generate regex
        procs # `ps` (process )alt.
        skim # `fzf` alt.
        dua # Disk usage
        tokei # Count lines of code
        ruplacer # Find & replace
        sd # Alt. find & replace
        hyperfine # Benchmarking
        file # File info
        fd # Find files
        onefetch # Fetch for git repos
        btop # System monitor
        bandwhich # Network monitor
        tealdeer # TLDR for commands
        ttyper # Typing practice
        bat # `cat` alt.
        wget # Download files
        neofetch # System info
        pipe-rename # `ls | renamer`
        zoxide # `cd` alt.
        eza # `ls` alt.
        glow # Print .md
        fuc # `rm,cp` -> `rmz,cpz`
        broot # Interactive file tree
        kalker # Calculator
        p7zip # 7z util
        difftastic # `diff` alt
        xclip # Clipboard utils
        cpu-x # Detailed sys info
        ;
      inherit (pkgs.bat-extras) batgrep;

      # ------------------------------------------ #

      # Desktop
      inherit (pkgs)
        gcolor3 # colour picker
        freetube # YT client
        bitwarden # Password manager
        floorp # Firefox fork
        onlyoffice-bin_latest # Office suite
        anki
        cryptomator # Encryption
        ;
      inherit (pkgs.xorg)
        xset # Key delay & repeat rate
        xev # Print xserver events
        ;

      # ------------------------------------------ #

      # Media
      inherit (pkgs)
        vivaldi-ffmpeg-codecs
        ffmpeg-full # Video/audio/etc utils
        imagemagick # Image utils
        yt-dlp
        alsa-utils

        # ------------------------------------------ #

        # Dev
        git-filter-repo
        chromium
        jq # JSON query
        just
        nixd
        cachix
        tree-sitter
        gcc
        nixfmt-rfc-style
        # `echo "GET <link>" | hurl -o ./out`
        hurl
        # `entr -rs <files> <commands>`

        # run commands on file change, -r(eload on each change), -s(hell envvar)
        entr
        ;
    };

    home.sessionVariables = {
      EDITOR = "micro";
    };
    home.sessionPath = [ "$HOME/.cargo/bin" ];
    home.file = {
      # ".screenrc".source = dotfiles/screenrc;
    };

    programs = {
      home-manager.enable = true;
      emacs.enable = true;
      direnv.enable = true;
      direnv.nix-direnv.enable = true;
      advancedCpMv.enable = true;
    };

    services = {
      emacs.enable = lib.mkIf config.programs.emacs.enable true;
    };

    news.display = lib.mkForce "silent";

    xsession.enable = true;
  };
}
