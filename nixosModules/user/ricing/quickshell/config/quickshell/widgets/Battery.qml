/*------------------------------
--- Battery widget by andrel ---
------------------------------*/

import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower
import "root:"

MouseArea { id: root
	// readonly property real percentage: 0
	readonly property real percentage: UPower.displayDevice.percentage
	readonly property bool isCharging: !UPower.onBattery

	property bool showPercentage: true
	property string colour: GlobalConfig.colour.foreground
	property string fontFamily: GlobalConfig.font.sans
	property int fontSize: GlobalConfig.font.size

	implicitWidth: layout.width
	implicitHeight: layout.height

	Row { id: layout
		spacing: 2

		// show battery percentage
		Text { id: percentage
			visible: showPercentage
			height: battery.height
			verticalAlignment: Text.AlignVCenter
			text: parseInt(root.percentage *100) + "%"
			font.family: fontFamily
			font.pointSize: 8
			color: colour
		}

		// battery icon
		Item { id: battery
			width: 25
			height: 12

			// dark charging icon
			Text {
				anchors.centerIn: battShell
				text: "󱐋"
				color: colour
				opacity: 0.7
				font.pointSize: 9
				visible: root.isCharging
			}

			// battery health bar
			Rectangle { id: healthBar
				// change colour of bar based on battery health
				readonly property string batteryHealth: {
					let health = null
					if (root.percentage <= 0.01) {
						health = GlobalConfig.colour.red
					} else if (root.percentage <= 0.33) {
						health = GlobalConfig.colour.orange
					} else {
						health = GlobalConfig.colour.green
					}
					return health;
				}

				anchors{ left: parent.left; leftMargin: 2; verticalCenter: parent.verticalCenter; }
				width: (parent.width -5) *root.percentage
				height: parent.height -4
				radius: 2
				color: batteryHealth
				layer.enabled: true
				layer.effect: DropShadow {
					color: healthBar.batteryHealth
					horizontalOffset: 0
					verticalOffset: 0
					spread: 0
					radius: 1
				}
			}

			// light charging icon
			Rectangle {
				anchors{ left: parent.left; leftMargin: 2; verticalCenter: parent.verticalCenter; }
				width: (parent.width -5) *root.percentage
				height: parent.height -4
				radius: 2
				color: "transparent"
				clip: true
				Item {
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: parent.left
					width: battery.width -5
					height: test.height
					Text { id: test
						anchors.centerIn: parent
						text: "󱐋"
						color: "black"
						opacity: 0.6
						font.pointSize: 9
						visible: root.isCharging
					}
				}
			}

			// battery overlay
			Rectangle { id: battShell
				anchors.left: parent.left
				width: parent.width -1
				height: parent.height
				color: "transparent"
				gradient: Gradient {
					orientation: Gradient.Vertical
					GradientStop { position: 0.0; color: "#80ffffff"; }
					GradientStop { position: 0.5; color: "#00000000"; }
					GradientStop { position: 1.0; color: "#40000000"; }
				}
				radius: 3
				border { color: colour; width: 1; }
			}

			Rectangle {
				anchors{ right: parent.right; verticalCenter: parent.verticalCenter; }
				width: 1
				height: 4
				color: colour
			}
		}
	}
}
