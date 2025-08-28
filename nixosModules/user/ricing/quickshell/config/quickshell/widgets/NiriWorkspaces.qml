/*--------------------------------------
--- Niri workspaces widget by andrel ---
--------------------------------------*/

import QtQuick
import Quickshell
import Quickshell.Io
import "root:"
import "niriWorkspaces"

Item { id: root
	// command to run on mouse pressed
	property list<string> command: ["niri", "msg", "action", "focus-workspace", root.workspace]
	property int spacing: GlobalConfig.spacing
	property string activeColour: GlobalConfig.colour.foreground
	property string inactiveColour: GlobalConfig.colour.grey
	property Rectangle activePill: Rectangle {
		width: 12
		height: 8
		radius: height /2
		color: activeColour
		border { width: 0; color: activeColour; }
	}
	property Rectangle inactivePill: Rectangle {
		width: 8
		height: 8
		radius: height /2
		color: inactiveColour
		border { width: 0; color: inactiveColour; }
	}
	property int workspace: 1

	implicitWidth: layout.implicitWidth
	implicitHeight: layout.implicitHeight

	Behavior on implicitWidth { NumberAnimation { duration: 150; }}

	Process { id: focusSpace
		running: false
		command: root.command
	}

	Row { id: layout
		anchors.verticalCenter: parent.verticalCenter

		spacing: root.spacing

		Repeater { id: workspaces
			model: NiriWorkspaces.numSpaces

			MouseArea {
				anchors.verticalCenter: parent.verticalCenter

				implicitWidth: pill.width
				implicitHeight: pill.height

				onClicked: {
					root.workspace = index +1
					focusSpace.running = true
				}

				// pill
				Rectangle { id: pill
					readonly property bool isCurrentSpace: index === (NiriWorkspaces.currentSpaces -1)

					width: isCurrentSpace ? root.activePill.width : root.inactivePill.width
					height: isCurrentSpace ? root.activePill.height : root.inactivePill.height
					radius: isCurrentSpace ? root.activePill.radius : root.inactivePill.radius
					color: isCurrentSpace ? root.activePill.color : root.inactivePill.color
					border {
						width: isCurrentSpace ? root.activePill.border.width : root.inactivePill.border.width
						color: isCurrentSpace ? root.activePill.border.color : root.inactivePill.border.color
						Behavior on width { NumberAnimation { duration: 150; }}
						Behavior on color { ColorAnimation { duration: 150; }}
					}
					Behavior on width { NumberAnimation { duration: 150; }}
					Behavior on height { NumberAnimation { duration: 150; }}
					Behavior on radius { NumberAnimation { duration: 150; }}
					Behavior on color { ColorAnimation { duration: 150; }}
				}
			}
		}
	}
}
