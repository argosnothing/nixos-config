import QtQuick
import Quickshell

Rectangle { id: pill
	required property int index

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
