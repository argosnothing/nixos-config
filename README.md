# △ NixOS Config △
* Non-dendritic configuration now lives on the [legacy](https://github.com/argosnothing/nixos-config/tree/legacy) branch. 
* Dendritic config based around import-tree and flake parts, with an emphasis on blurring the lines between home and system.
* If you are one of those mentioned in the credits here and don't want to be mentioned, just let me know.

# Things I do
* Dendritic pattern with modules folder being evaluated at flake level.
* Impermanence in system and home. Per module persistance so wm switches don't pollute user space.
* Sops dependent install process, bring your own keys, secrets.
* Coupled user/system modules, inspired by [saygo's](https://github.com/saygo-png/nixos) configuration.
* Some code here, such as the impermanence module is ~~stolen~~ borrowed from [iynaix's](https://github.com/iynaix/dotfiles) config

## Important Files
* [Flake entrypoint](flake.nix)
* [nixosConfigurations.nix](modules/nixosConfigurations.nix)
  * [+mk-os.nix](modules/utility/+mk-os.nix) (Implementation for linux host create func)

### Meta
* My aspiration is that this repo will be beginner friendly enough to be used as an educational tool for learning to create your own config. If there is anywhere you feel could be explained in more detail feel free to message me, and I will work towards incorporating it in a README.md file in the appropriate directory. 
  * I also have a [starter config](https://github.com/argosnothing/nixos-kickstart) that has a similar structure if you want to start from scratch with stuff like dendritic and zfs.
* My config makes heavy use of README.md, and I try to have every directory contain its own readme with more granular descriptions of its purpose and modules.

### Notes, implementation details.
* `home-manager.users.username` has been aliased to `hm`. hjems user has been similarly aliased to `hj`
* Themes are handled as standalone modules, currently rose-pine is the only one i've really configured.

# Credits
 For collectively dragging me, kicking and screaming, across multiple finish lines
* [Jet](https://github.com/Michael-C-Buckley/home-config)
* [Iynaix](https://github.com/iynaix/dotfiles)
* [Saygo](https://github.com/saygo-png/nixos)
* [Emzy](https://github.com/emzywastaken/dotfiles)
* [Tony, BTW](https://www.tonybtw.com/)
