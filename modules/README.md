# Modules
Every .nix file in this folder and its subfolders get ran at the flake-parts level.

I do not split up folders for the purposes of system vs home. These two parts of the system are conflated for simplicity. Some modules will exist in homeManager, others might exist in the system, but use home manager half way through the file. Hopefully I'll add more here to explain the interaction and additional justifications for this choice. 
