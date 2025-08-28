/*------------------------------------
--- Tray item component by andrel ---*
------------------------------------*/

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "root:"
import "root:tools"

Item { id: root
	required property SystemTrayItem modelData

	property int iconSize
	property bool menuOpen: false

	width: icon.width
	height: icon.height

	IconImage { id: icon
		anchors.centerIn: parent
		implicitSize: iconSize
		source: root.modelData.icon
	}

	// use system context menu
	QsMenuAnchor { id: menu
		menu: root.modelData.menu
		anchor.item: root
		anchor.margins.top: GlobalConfig.barHeight
	}

	Popout { id: popoutMenu
		anchor: root
		content: TrayItemMenuHandler { id: menuHandler
			activeMenu: [root.modelData.menu]
		}
		// debug: true
	}

	MouseArea { id: mouseArea
		anchors.fill: parent
		acceptedButtons: Qt.LeftButton | Qt.RightButton
		onClicked: event => {
			if (menuOpen) {
				popoutMenu.close();
				menuHandler.activeMenu = [root.modelData.menu];
				menuOpen = false;
			} else if (event.button === Qt.LeftButton) {
				popoutMenu.closeAll();
				menuHandler.activeMenu = [root.modelData.menu]
				modelData.activate();
			} else {
				// menu.open()
				popoutMenu.open()
				menuOpen = true
			}
		}
	}
}
