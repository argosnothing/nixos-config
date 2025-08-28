import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import "root:"
import "brightness"

Scope { id: root
	readonly property real brightness: Brightness.currentBright /Brightness.maxBright

	property bool shouldShowOsd: false
	property string colour: GlobalConfig.colour.accent

	Connections {
		target: Brightness

		function onCurrentBrightChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

	Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.shouldShowOsd = false
	}

	LazyLoader {
		active: root.shouldShowOsd

		PanelWindow {
			WlrLayershell.layer: WlrLayer.Overlay
			anchors.bottom: true
			margins.bottom: screen.height *(5/12)
			implicitWidth: 200
			implicitHeight: 30
			color: "transparent"
			mask: Region {}

			Rectangle {
				anchors.fill: parent
				radius: height / 2
				color: GlobalConfig.colour.background

				RowLayout {
					anchors {
						fill: parent
						leftMargin: 10
						rightMargin: 15
					}
					spacing: 8

					IconImage {
						implicitSize: 16
						source: {
							let icon = Quickshell.iconPath("display-brightness")
							if ((root.brightness ?? 0) < 0.01) {
								icon = Quickshell.iconPath("display-brightness-off")
							} else if ((root.brightness ?? 0) >= 0.01 && (root.brightness ?? 0) < 0.33)  {
								icon = Quickshell.iconPath("display-brightness-low")
							} else if ((root.brightness ?? 0) >= 0.33 && (root.brightness ?? 0) < 0.66) {
								icon = Quickshell.iconPath("display-brightness-medium")
							} else if ((root.brightness ?? 0) >= 0.66) {
								icon = Quickshell.iconPath("display-brightness-high")
							}
							return icon;
						}
					}

					Rectangle { id: scrollBar
						Layout.fillWidth: true
						anchors.verticalCenter: parent.verticalCenter
						height: 6
						radius: height /2
						border { color: "#60000000"; width: 1; }
						gradient: Gradient {
							orientation: Gradient.Vertical
							GradientStop { position: 0.0; color: "#60000000" }
							GradientStop { position: 1.0; color: "#30000000" }
						}

						Rectangle { id: scrollElapsed
							readonly property int bright: scrollBar.width *root.brightness;

							width: bright < (height) ? 0 : bright
							height: scrollBar.height
							radius: height /2
							color: root.colour
						}

						Rectangle {
							anchors.fill: scrollElapsed
							radius: height /2
							gradient: Gradient {
								orientation: Gradient.Vertical
								GradientStop { position: 0.0; color: "#80ffffff" }
								GradientStop { position: 0.5; color: "#00000000" }
								GradientStop { position: 1.0; color: "#40000000" }
							}
						}
					}
				}
			}
		}
	}
}
