# nixos-config

**Configuration flow:**    
-> flake.nix    
-> hosts/default.nix    
-> hosts/*{xyzhostname}*/default.nix   
-> hosts/*{xyzhostname}*[/home.nix|/configuration.nix]  
-> From there just follow the imports = []    


**Notes**  
* If an import is a directory, this is nix shorthand for directory/default.nix
* flake.nix imports the hosts/default.nix attributes, typically those are in flake.nix, but don't like the idea of flake.nix being any more than just inputs for my config. 
hosts/default.nix has TWO entry points. nixosConfigurations and homeConfigurations. I have a standalone home-manager setup so building system level and home level are different commands. ( see [here](./nixosModules/user/apps/terminal/nixos-aliases.nix) for shorthands of these commands ) 
