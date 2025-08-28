/*------------------------------
--- Network widget by andrel ---
------------------------------*/

import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets
import "root:"
import "network"

Item { id: root
	property int iconSize: GlobalConfig.iconSize

	// get the network type
	readonly property string networkType: {
		let type = "disconnected"
		if (ActiveNetwork.netType) {
			type = ActiveNetwork.netType
		}
		return type;
	}
	// get the signal strength if the connection is wireless
	readonly property int networkStrength: {
		let strength = 0
		if (networkType === 'wifi') {
			strength = Math.round(ActiveNetwork.netStrength /25) *25;	// round the signal strength to the nearest quarter
		}
		return strength;
	}

	width: icon.width
	height: icon.height

	IconImage { id: icon
		implicitSize: 16
		source: {
			let symbol = Quickshell.iconPath("nm-no-connection")
			if (root.networkType === 'ethernet') {
				symbol = Quickshell.iconPath("nm-device-wired")
			} else if (root.networkType === 'wifi') {
				if (root.networkStrength === 0) {
					symbol = Quickshell.iconPath("network-wireless-signal-none")
				} else if (root.networkStrength === 25) {
					symbol = Quickshell.iconPath("network-wireless-signal-weak")
				} else if (root.networkStrength === 50) {
					symbol = Quickshell.iconPath("network-wireless-signal-ok")
				} else if (root.networkStrength === 75) {
					symbol = Quickshell.iconPath("network-wireless-signal-good")
				} else if (root.networkStrength === 100) {
					symbol = Quickshell.iconPath("network-wireless-signal-excellent")
				}
			}
			return symbol;
		}
	}
}
