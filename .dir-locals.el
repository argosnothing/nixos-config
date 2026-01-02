((nil .  ((eglot-workspace-configuration
          .  (:nixd (:nixpkgs (:expr "import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs { }")
                             :formatting (:command ["nixfmt"])
                             :options (:laptop (:expr "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.laptop.options")
                                       :desktop (:expr "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.desktop.options"))))))))
