/*--------------------------------
--- Bluetooth widget by andrel ---
--------------------------------*/

import QtQuick
import Quickshell
import Quickshell.Widgets
import "root:"
import "bluetooth"

Item { id: root
	property int iconSize: GlobalConfig.iconSize

	implicitWidth: icon.implicitWidth
	implicitHeight: icon.implicitHeight

	IconImage { id: icon
		readonly property string bluetoothState: {
			let bluState = "bluetooth-disabled"
			if (Bluetooth.powered) {
				if (Bluetooth.paired) {
					bluState = "bluetooth-paired"
				} else {
					bluState = "bluetooth-active"
				}
			}
			return bluState;
		}
		source: Quickshell.iconPath(bluetoothState)
		implicitSize: root.iconSize
	}
}
