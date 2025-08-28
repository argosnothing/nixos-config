/*------------------------------------------------
--- Rounded screen corners component by andrel ---
------------------------------------------------*/

import QtQuick
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import Quickshell
import "root:"

PanelWindow { id: root
	// a hack for Niri desktops; setting all anchors "true" has unintended effect
	anchors {
		top: true
		left: true
		// right: true
		// bottom: true
	}

	implicitWidth: screen.width
	implicitHeight: screen.height

	color: "transparent"
	mask: Region {}

	property list<string> corners: []
	property int cornerRadius: GlobalConfig.cornerRadius
	property int shadowMargin: GlobalConfig.padding
	property string colour: GlobalConfig.colour.background

	Rectangle { id: topLeft

		visible: corners.includes("top-right")
		color: colour

		anchors.top: parent.top; anchors.left: parent.left;

		width: cornerRadius; height: cornerRadius;
		layer.enabled: true
		layer.effect: OpacityMask {
			maskSource: Rectangle {
				width: topLeft.width
				height: topLeft.height
				color: "transparent"
				visible: false
				Rectangle {
					anchors.verticalCenter: parent.bottom; anchors.horizontalCenter: parent.right;
					width: cornerRadius *2
					height: cornerRadius *2
					radius: cornerRadius
					color: "black"
				}
			}
			invert: true
		}
	}

	Rectangle { id: topRight

		visible: corners.includes("top-right")
		color: colour

		anchors.top: parent.top; anchors.right: parent.right;

		width: cornerRadius; height: cornerRadius;
		layer.enabled: true
		layer.effect: OpacityMask {
			maskSource: Rectangle {
				width: topRight.width
				height: topRight.height
				color: "transparent"
				visible: false
				Rectangle {
					anchors.verticalCenter: parent.bottom; anchors.horizontalCenter: parent.left;
					width: cornerRadius *2
					height: cornerRadius *2
					radius: cornerRadius
					color: "black"
				}
			}
			invert: true
		}
	}

	Rectangle { id: bottomLeft

		visible: corners.includes("bottom-left")
		color: colour

		anchors.bottom: parent.bottom; anchors.left: parent.left;

		width: cornerRadius; height: cornerRadius;
		layer.enabled: true
		layer.effect: OpacityMask {
			maskSource: Rectangle {
				width: bottomLeft.width
				height: bottomLeft.height
				color: "transparent"
				visible: false
				Rectangle {
					anchors.verticalCenter: parent.top; anchors.horizontalCenter: parent.right;
					width: cornerRadius *2
					height: cornerRadius *2
					radius: cornerRadius
					color: "black"
				}
			}
			invert: true
		}
	}

	Rectangle { id: bottomRight

		visible: corners.includes("bottom-right")
		color: colour

		anchors.bottom: parent.bottom; anchors.right: parent.right;

		width: cornerRadius; height: cornerRadius;
		layer.enabled: true
		layer.effect: OpacityMask {
			maskSource: Rectangle {
				width: bottomRight.width
				height: bottomRight.height
				color: "transparent"
				visible: false
				Rectangle {
					anchors.verticalCenter: parent.top; anchors.horizontalCenter: parent.left;
					width: cornerRadius *2
					height: cornerRadius *2
					radius: cornerRadius
					color: "black"
				}
			}
			invert: true
		}
	}
}
