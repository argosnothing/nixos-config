# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "The Flake of Turtle";

  outputs = inputs: import ./outputs.nix inputs;

  nixConfig = {
    allow-import-from-derivation = true;
  };

  inputs = {
    dank-shell = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
        quickshell = {
          follows = "quickshell";
        };
      };
      url = "github:AvengeMedia/DankMaterialShell";
    };
    flake-file = {
      url = "github:vic/flake-file";
    };
    flake-parts = {
      inputs = {
        nixpkgs-lib = {
          follows = "nixpkgs";
        };
      };
      url = "github:hercules-ci/flake-parts";
    };
    hjem = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
      url = "github:/feel-co/hjem";
    };
    home-manager = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
      url = "github:nix-community/home-manager";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    import-tree = {
      url = "github:vic/import-tree";
    };
    mango = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
      url = "github:DreamMaoMao/mango";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
    };
    nix-flatpak = {
      url = "https://flakehub.com/f/gmodena/nix-flatpak/0.6.0.tar.gz";
    };
    nixos-grub-themes = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
      url = "github:jeslie0/nixos-grub-themes";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-stable = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    noctalia-shell = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
        quickshell = {
          follows = "quickshell";
        };
      };
      url = "github:noctalia-dev/noctalia-shell";
    };
    nvf = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
      url = "github:notashelf/nvf";
    };
    occult-theme = {
      url = "github:/argosnothing/occult-theme";
    };
    oxwm = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
      url = "github:tonybanters/oxwm";
    };
    quickshell = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
      url = "github:outfoxxed/quickshell";
    };
    sops-nix = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
      url = "github:Mic92/sops-nix";
    };
    std = {
      url = "github:chessai/nix-std";
    };
    stylix = {
      url = "github:nix-community/stylix";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };
    winboat = {
      url = "github:TibixDev/winboat";
    };
    zwift = {
      url = "github:netbrain/zwift";
    };
  };
}
