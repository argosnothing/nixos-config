((nil .  ((eglot-workspace-configuration
          .  (:nixd (:nixpkgs (:expr "import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs { }")
                             :formatting (:command ["nixfmt"])
                             :options (:desktop (:expr "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.desktop.options"))))))))
