/*---------------------------
--- Tray widget by andrel ---
---------------------------*/

import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "root:"
import "tray"
import "tools/popout"

Item { id: root
	property int iconSize: GlobalConfig.iconSize
	property int trayItemCount: 0

	implicitWidth: layout.width
	implicitHeight: layout.height

	Connections {
		target: Quickshell
		onReloadCompleted: {
			trayItemCount = trayItems.count
			Quickshell.inhibitReloadPopup()
		}
	}

	Timer { id: timer
		interval: 500
		running: false
		repeat: false
		onTriggered: {
			if (trayItems.count !== root.trayItemCount) {
				Quickshell.reload(false)
			}
		}
	}

	Row { id: layout
		spacing: 2

		Repeater { id: trayItems
			model: SystemTray.items
			onItemAdded: timer.running = true
			onItemRemoved: trayItemCount = count

			TrayItem {
				iconSize: root.iconSize
			}
		}
	}
}
