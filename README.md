# nixos-config
Lowkey losing my mind moving over parts of my old setup to this. Originally based everything off of librephoenix's setup, but ultimately it was overcomplicated for my use case. Focus on simplicity, at least to the degree that that is possible with the aspiration of handling both multiple hosts and multiple desktop environments. 

the flake is just for inputs, and wiring up configurations is done through hosts/default.nix, which essentially just merges a bunch of configuration attributes from every subfolder. Each subfolder is essentially responsible for its own configuration, with nixosModules trying to act as a shared repository for them. For example, my desktop uses hyprland, which takes a significant amount of configuration to make a functional environment, so while i offshore that to nixosModules, ideally all the hyprland specific stuff is inside nixosModules/system/wm/hyprland and nixosModules/user/wm/hyprland. But a laptop i want to use just a basic gnome setup might just have that all live within its host directory if it does not require significant configuration. 

Theming is dependent on host, but hyprland is using stylix, with its config currently in a more general directory in modules. 

Notes to self: 
sddm + hyprland = pain? logging in too quick causes xdg-portal crashes? why?
hyprland dynamic cursors + home manager switches = pain? appears to cause crashes? ever since disabling this i have not been booted from wayland. 
