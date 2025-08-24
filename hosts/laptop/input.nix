{ ... }:

{
  # P51-specific touchpad and TrackPoint configuration
  services.libinput = {
    enable = true;
    touchpad = {
      # Reduce touchpad sensitivity (too fast by default)
      accelSpeed = "-0.6";  # Range: -1.0 to 1.0, negative = slower
      accelProfile = "flat";
      naturalScrolling = false;
      tapping = true;
      disableWhileTyping = true;
    };
  };

  # TrackPoint configuration via udev rules
 #services.udev.extraRules = ''
 #  # ThinkPad P51 TrackPoint - increase sensitivity and speed (actual device name)
 #  SUBSYSTEM=="input", ATTR{name}=="TPPS/2 IBM TrackPoint", ATTR{device/sensitivity}="200"
 #  SUBSYSTEM=="input", ATTR{name}=="TPPS/2 IBM TrackPoint", ATTR{device/speed}="150"
 #  
 #  # Alternative patterns for different TrackPoint device names
 #  SUBSYSTEM=="input", ATTR{name}=="*TrackPoint*", ATTR{device/sensitivity}="200"
 #  SUBSYSTEM=="input", ATTR{name}=="*TrackPoint*", ATTR{device/speed}="150"
 #'';
}
