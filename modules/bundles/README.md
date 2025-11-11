# bundles
### `modules.nixos.base`
* Generally if a module is imported here it's expected to be necessary for base-system functionality **or** it's a module i don't see myself ever having a reason to not be enabled regardless of host.
### `modules.nixos.gui-apps`
* Similar to base, these are modules I consider necessary for base functionality in a desktop/wm environment. For example, most applications I use make the assumption that stylix is going to be enabled, so I have it imported here. More information on how I deal with stylix and theming can be found in [README.md](../features/gui/themes/README.md)
* In addition, I also throw in things that arn't necessary but I know I will want on all my hosts anyways. 
### wm-bundles.nix
* This *file* stores modules that act as wrappers for window managers and desktops. I try to make each module as standalone as possible.
* for example, my `modules.nixos.niri` module only focuses on niri itself, but when I enable niri I am going to want more than just niri for a truly functional window manager. I'll want a quickshell dot, maybe `modules.nixos.dms` or `modules.nixos.noctalia-shell` and i'll also want some kind of display manager to host the niri session. I prefer the hosts only care about the higher level functionality of a desktop environment, and not worry about how I prefer to put environment together, as i'm always tweaking these environments. So i try to decouple that from each host when possible/convenient. 

