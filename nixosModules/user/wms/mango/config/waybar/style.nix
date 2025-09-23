{
  config,
  lib,
  ...
}: let
  raw = config.lib.stylix.colors or config.stylix.base16Scheme;

  hasHash = s: lib.strings.hasPrefix "#" s;
  normalize = s:
    if hasHash s
    then s
    else "#${s}";
  c = lib.mapAttrs (_: normalize) raw;

  # Append alpha to a #RRGGBB -> #RRGGBBAA (GTK CSS supports this)
  withAlpha = color: alphaHex: "#${lib.strings.removePrefix "#" color}${alphaHex}";
in ''
  #workspaces {
    border-radius: 4px;
    border-width: 2px;
    border-style: solid;
    border-color: ${c.base0A};
    margin-left: 4px;
    padding-left: 10px;
    padding-right: 6px;
    background: ${withAlpha c.base00 "C2"};
  }

  #workspaces button {
    border: none;
    background: none;
    box-shadow: inherit;
    text-shadow: inherit;
    color: ${c.base0A};
    padding: 1px 1px;
    margin: 0 2px;
  }

  #workspaces button.hidden {
    color: ${c.base03};
    background-color: transparent;
  }

  #workspaces button.visible { color: ${c.base0A}; }
  #workspaces button:hover   { color: ${c.base09}; }

  #workspaces button.active {
    background-color: ${c.base0A};
    color: ${c.base00};
    margin-top: 5px;
    margin-bottom: 5px;
    padding-top: 1px;
    padding-bottom: 0px;
    border-radius: 3px;
  }

  #workspaces button.urgent {
    background-color: ${c.base08};
    color: ${c.base00};
    margin-top: 5px;
    margin-bottom: 5px;
    padding-top: 1px;
    padding-bottom: 0px;
    border-radius: 3px;
  }

  #tags { background-color: transparent; }

  #tags button {
    background-color: ${c.base07};
    color: ${c.base0E};
  }

  #tags button:not(.occupied):not(.focused) {
    font-size: 0;
    min-width: 0;
    min-height: 0;
    margin: -17px;
    padding: 0;
    color: transparent;
    background-color: transparent;
  }

  #tags button.occupied {
    background-color: ${c.base07};
    color: ${c.base0A};
  }

  #tags button.focused {
    background-color: ${c.base0E};
    color: ${c.base00};
  }

  #tags button.urgent {
    background: ${c.base08};
    color: ${c.base00};
  }

  #window {
    background-color: ${c.base0A};
    color: ${c.base00};
  }
''
