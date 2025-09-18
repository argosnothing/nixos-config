{
  pkgs,
  settings,
  ...
}: {
  home.packages = [
    pkgs.zsh-powerlevel10k
    (pkgs.writeShellApplication
      {
        name = "show-tmpfs";
        runtimeInputs = [pkgs.fd];
        text = ''
          sudo fd --one-file-system --base-directory / --type f --hidden \
            --exclude "/etc/{ssh,passwd,shadow}" \
            --exclude "*.timer" \
            --exclude "/var/lib/NetworkManager" \
            --exec ls -lS | sort -rn -k5 | awk '{print $5, $9}'
        '';
      })
  ];
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = ''
      {
        "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
        "palette": {
              "os": "#ACB0BE",
              "closer": "p:os",
              "pink": "#F4B8E4",
              "lavender": "#BABBF1",
              "blue":  "#8CAAEE"
        },
        "blocks": [
          {
            "alignment": "left",
            "segments": [
              {
                "foreground": "p:os",
                "style": "plain",
                "template": "{{.Icon}} ",
                "type": "os"
              },
              {
                "foreground": "p:blue",
                "style": "plain",
                "template": "{{ .UserName }}@{{ .HostName }} ",
                "type": "session"
              },
              {
                "foreground": "p:pink",
                "properties": {
                  "folder_icon": "..\ue5fe..",
                  "home_icon": "~",
                  "style": "agnoster_short"
                },
                "style": "plain",
                "template": "{{ .Path }} ",
                "type": "path"
              },
              {
                "foreground": "p:lavender",
                "properties": {
                  "branch_icon": "\ue725 ",
                  "cherry_pick_icon": "\ue29b ",
                  "commit_icon": "\uf417 ",
                  "fetch_status": false,
                  "fetch_upstream_icon": false,
                  "merge_icon": "\ue727 ",
                  "no_commits_icon": "\uf0c3 ",
                  "rebase_icon": "\ue728 ",
                  "revert_icon": "\uf0e2 ",
                  "tag_icon": "\uf412 "
                },
                "template": "{{ .HEAD }} ",
                "style": "plain",
                "type": "git"
              },
              {
                "style": "plain",
                "foreground": "p:closer",
                "template": "\uf105",
                "type": "text"
              }
            ],
            "type": "prompt"
          }
        ],
        "final_space": true,
        "version": 3
      }
    '';
  };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "z"
        "direnv"
        "history"
        "colored-man-pages"
        "extract"
        "command-not-found"
        "aliases"
        "docker"
        "kubectl"
        "virtualenv"
        "vi-mode"
      ];
      #theme = "lambda";
      #custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
    };
    shellAliases = import ./nixos-aliases.nix {inherit settings;};
    initContent = ''
      [[ -f ~/.profile ]] && source ~/.profile
    '';
    envExtra = ''
      export EDITOR=vim
      export VISUAL=vim
    '';
  };
  home.file.".p10k.zsh".source = ./.p10k.zsh;
}
