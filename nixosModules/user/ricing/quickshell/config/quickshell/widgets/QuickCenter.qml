/*-----------------------------------
--- Quick center widget by andrel ---
-----------------------------------*/

import QtQuick
import Quickshell
import Quickshell.Widgets
import "root:"

Item { id: root
	property bool showQuickCenter: false

	width: icon.width
	height: icon.height

	MouseArea {
		anchors.fill: parent
		onClicked: {
			showQuickCenter = !showQuickCenter
		}

		IconImage { id: icon
			implicitSize: 16
			source: Quickshell.iconPath("notification")
		}
	}

	PanelWindow { id: quickCenter
		anchors { left: true; top: true; }

		implicitWidth: screen.width
		implicitHeight: screen.height
		color: "transparent"
		mask: Region {}

		Item {
			anchors { verticalCenter: parent.verticalCenter; }
			x: quickCenter.width -(showQuickCenter? (window.width +6) : 0)
			width: window.width
			height: window.height
			Behavior on x { NumberAnimation{ duration: 300; easing.type: Easing.OutCubic; }}

			Rectangle { id: window
				width: quickCenter.width /4
				height: quickCenter.height -12
				radius: 8
				color: "red"
			}
		}
	}
}
