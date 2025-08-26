# nixos-config

**Configuration flow:**    
-> flake.nix    
-> hosts/default.nix    
-> hosts/*{xyzhostname}*/default.nix   
-> hosts/*{xyzhostname}*[/home.nix|/configuration.nix]  
-> From there just follow the imports = []    
