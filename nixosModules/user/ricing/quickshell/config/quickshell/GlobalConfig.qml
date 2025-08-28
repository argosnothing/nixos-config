pragma Singleton

import Quickshell
import QtQuick

Singleton { id: root
	readonly property Colour colour: Colour {}
	readonly property Font font: Font {}

	readonly property int padding: 10
	readonly property int spacing: 6
	readonly property int cornerRadius: 8

	readonly property int barHeight: 28

	readonly property int iconSize: 16

	component Colour: QtObject {
		readonly property string foreground: "#cad3f5"
		readonly property string midground: "#b8c0e0"
		readonly property string background: "#fa181926"
		readonly property string accent: "#8aadf4"
		readonly property string red: "#ed8796"
		readonly property string orange: "#f5a97f"
		readonly property string yellow: "#eed49f"
		readonly property string green: "#a6da95"
		readonly property string blue: "#8aadf4"
		readonly property string purple: "#c6a0f6"
		readonly property string aqua: "#8bd5ca"
		readonly property string grey: "#363a4f"
	}

	component Font: QtObject {
		readonly property string sans: "Adwaita Sans Regular"
		readonly property string mono: "JetBrains Mono Nerd Font"
		readonly property int size: 10
		readonly property int small: 8
		readonly property int semibold: 600
	}
}
