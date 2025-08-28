import QtQuick
import QtMultimedia
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Wayland
import "root:"

Scope { id: root
	readonly property bool isMuted: Pipewire.defaultAudioSink?.audio.muted
	readonly property real volume: Pipewire.defaultAudioSink?.audio.volume

	property bool shouldShowOsd: false
	property string colour: GlobalConfig.colour.accent

	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

	Connections {
		target: Pipewire.defaultAudioSink?.audio

		function onMutedChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
		function onVolumeChanged() {
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
							let icon = Quickshell.iconPath("audio-volume-muted")
							if ((root.isMuted ?? true) || (root.volume ?? 0) < 0.01) {
								icon = Quickshell.iconPath("audio-volume-muted")
							} else if ((root.volume ?? 0) >= 0.01 && (root.volume ?? 0) < 0.33)  {
								icon = Quickshell.iconPath("audio-volume-low")
							} else if ((root.volume ?? 0) >= 0.33 && (root.volume ?? 0) < 0.66) {
								icon = Quickshell.iconPath("audio-volume-medium")
							} else if ((root.volume ?? 0) >= 0.66) {
								icon = Quickshell.iconPath("audio-volume-high")
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
							readonly property int vol: scrollBar.width *root.volume;

							width: vol < (height) ? 0 : vol
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
