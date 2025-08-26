# nixos-config

**Configuration flow:**    
-> flake.nix    
-> hosts/default.nix    
-> hosts/*{xyzhostname}*/default.nix   
-> hosts/*{xyzhostname}*[/home.nix|/configuration.nix]  
-> From there just follow the imports = []    


**Notes**  
If an import is a directory, this is nix shorthand for directory/default.nix
