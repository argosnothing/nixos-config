{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    yazi.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable yazi terminal file manager.";
    };
  };

  config = lib.mkIf config.yazi.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        mgr = {
          layout = [1 4 3];  # Sidebar, main, preview columns ratio
          sort_by = "alphabetical";
          sort_sensitive = false;
          sort_reverse = false;
          sort_dir_first = true;
          linemode = "size";  # Show file sizes
          show_hidden = true;
          show_symlink = true;
        };

        preview = {
          tab_size = 2;
          max_width = 600;
          max_height = 900;
          cache_dir = "${config.xdg.cacheHome}/yazi";
        };

        opener = {
          # Text files
          edit = [
            {run = "hx \"$@\""; block = true; for = "unix";}
          ];
          # Images
          image = [
            {run = "imv \"$@\""; desc = "Image Viewer";}
          ];
          # Videos  
          video = [
            {run = "mpv \"$@\""; desc = "Media Player";}
          ];
          # Archives
          archive = [
            {run = "unar \"$1\""; desc = "Extract Archive";}
          ];
          # PDFs
          pdf = [
            {run = "zathura \"$@\""; desc = "PDF Viewer";}
          ];
        };

        open = {
          rules = [
            {name = "*/"; use = ["edit" "open"];}
            
            {mime = "text/*"; use = ["edit" "reveal"];}
            {mime = "application/json"; use = ["edit" "reveal"];}
            {mime = "*/xml"; use = ["edit" "reveal"];}
            
            {mime = "image/*"; use = ["image" "reveal"];}
            
            {mime = "video/*"; use = ["video" "reveal"];}
            {mime = "audio/*"; use = ["video" "reveal"];}
            
            {mime = "application/zip"; use = ["archive" "reveal"];}
            {mime = "application/gzip"; use = ["archive" "reveal"];}
            {mime = "application/x-tar"; use = ["archive" "reveal"];}
            {mime = "application/x-bzip2"; use = ["archive" "reveal"];}
            {mime = "application/x-7z-compressed"; use = ["archive" "reveal"];}
            
            {mime = "application/pdf"; use = ["pdf" "reveal"];}
          ];
        };
      };

      # Custom keybindings
      keymap = {
        mgr.prepend_keymap = [
          {on = [ "g" "h" ]; run = "cd ~"; desc = "Go to home directory";}
          {on = [ "g" "c" ]; run = "cd ~/.config"; desc = "Go to config directory";}
          {on = [ "g" "n" ]; run = "cd ~/nixos-config"; desc = "Go to nixos-config";}
          {on = [ "g" "d" ]; run = "cd ~/Downloads"; desc = "Go to downloads";}
          {on = [ "g" "D" ]; run = "cd ~/Documents"; desc = "Go to documents";}
          {on = [ "g" "p" ]; run = "cd ~/Pictures"; desc = "Go to pictures";}
          
          # Create new file/directory
          {on = [ "a" "f" ]; run = "create --file"; desc = "Create new file";}
          {on = [ "a" "d" ]; run = "create --dir"; desc = "Create new directory";}
          
          # Toggle hidden files
          {on = [ "." ]; run = "hidden toggle"; desc = "Toggle hidden files";}
          
          # Better quit
          {on = [ "Q" ]; run = "quit --no-cwd-file"; desc = "Quit without changing directory";}
        ];
      };
    };

    # Additional packages for yazi functionality
    home.packages = with pkgs; [
      # Yazi itself (programs.yazi.enable should install this, but let's be explicit)
      yazi
      
      # Essential for yazi operations
      file          # File type detection
      tree          # Directory tree display
      
      # Preview dependencies (some may already be in Niri config)
      ffmpegthumbnailer  # Video thumbnails
      unar              # Archive extraction
      poppler_utils     # PDF previews
      imagemagick       # Image operations
      
      # Optional applications for opening files
      imv              # Image viewer
      mpv              # Media player  
      zathura          # PDF viewer
    ];
  };
}