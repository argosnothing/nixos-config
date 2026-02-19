# △ NixOS Config △

- Non-dendritic configuration now lives on the
  [legacy](https://github.com/argosnothing/nixos-config/tree/legacy)
  branch.
- Dendritic config that blurs the line between home and system.
- If you are one of those mentioned in the credits here and don't want
  to be mentioned, just let me know.

## Things I do

- Dendritic pattern with modules and packages folders being evaluated at flake level.
- Impermanence in system and home. Per module persistance so wm switches
  don't pollute user space.
- Hjem
- Sops dependent install process, bring your own keys, secrets.
- Coupled user/system modules, inspired by
  [saygo's](https://github.com/saygo-png/nixos) configuration.
- Some code here, such as the impermanence module is +stolen+ borrowed
  from [iynaix's](https://github.com/iynaix/dotfiles) config

### Important Files

- [Flake entrypoint](flake.nix)
- [nixosConfigurations.nix](modules/nixosConfigurations.nix)
  - [+mk-os.nix](modules/utility/+mk-os.nix) (Implementation for
    linux host create func)

#### Meta

- I also have a [starter config](https://github.com/argosnothing/nixos-kickstart)
that has a similar structure if you want to start from scratch with
stuff like dendritic and zfs, although I need to update it  :p

#### Notes, implementation details.

- hjem user module is aliased to `hj`
- Themes are currently largely handled `imperatively` through noctalia
- Most of my wm configs use a hybrid approach of hjem-impure for symlinking and
  nix-generated files to carry over things like monitor data and storepaths. 

## Credits

For collectively dragging me, kicking and screaming, across multiple
finish lines

- [Jet](https://github.com/Michael-C-Buckley/nixos)
- [Iynaix](https://github.com/iynaix/dotfiles)
- [Saygo](https://github.com/saygo-png/nixos)
- [Emzy](https://github.com/emzywastaken/dotfiles)
- [Tony, BTW](https://www.tonybtw.com/)
