/*-----------------------------------
--- Music player widget by andrel ---
-----------------------------------*/

import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import "root:"

Item { id:root
	readonly property list<MprisPlayer> players: Mpris.players.values
	readonly property MprisPlayer activePlayer: {
		for (var i = 0; i < players.length; i++) {
			if (players[i].isPlaying && players[i].identity === "Spotify")
				return players[i]
		}
		for (var i = 0; i < players.length; i++) {
			if (players[i].isPlaying)
				return players[i]
		}
		return players.length > 0 ? players[players.length - 1] : null
	}

	property int trackLength: 150
	property int scrollSpeed: 45
	property int scrollbarHeight: 6
	property int iconSize: GlobalConfig.iconSize
	property int padding: GlobalConfig.spacing
	property string colour: GlobalConfig.colour.foreground
	property string colourMid: GlobalConfig.colour.midground
	property string colourBar: GlobalConfig.colour.accent
	property string fontFamily: GlobalConfig.font.sans
	property int fontSize: GlobalConfig.font.small
	property int fontWeight: GlobalConfig.font.semibold

	implicitWidth: layout.width
	implicitHeight: layout.height

	// format time from total seconds to minute:seconds
	function formatTime(totalSeconds) {
		var minutes = Math.floor(totalSeconds /60);
		var seconds = totalSeconds %60;
		return `${minutes}:${seconds < 10 ? "0" + seconds : seconds}`;
	}

	// update the active player's position while playing
	FrameAnimation {
		running: activePlayer.playbackState == MprisPlaybackState.Playing
		onTriggered: activePlayer.positionChanged()
	}

	// blurred album art
	Rectangle { id: artHMask
		width: layout.width
		height: 32
		color: "transparent"
		radius: 4
		layer.enabled: true
		layer.effect: OpacityMask {
			maskSource: Rectangle {
				width: artHMask.width
				height: artHMask.height
				gradient: Gradient {
					orientation: Gradient.Horizontal
					GradientStop { position: 0.0; color: "#00000000" }
					GradientStop { position: 0.5; color: "#90000000" }
					GradientStop { position: 1.0; color: "#00000000" }
				}
			}
		}
		clip: true

		Rectangle { id: artVMask
			anchors.fill: parent
			color: "transparent"
			radius: 4
			layer.enabled: true
			layer.effect: OpacityMask {
				maskSource: Rectangle {
					width: artVMask.width
					height: artVMask.height
					gradient: Gradient {
						orientation: Gradient.Vertical
						GradientStop { position: 0.0; color: "#00000000" }
						GradientStop { position: 0.5; color: "#ff000000" }
						GradientStop { position: 1.0; color: "#00000000" }
					}
				}
			}
			clip: true

			IconImage { id: trackAlbumArt
				anchors.centerIn: parent
				implicitSize: layout.width
				source: activePlayer.trackArtUrl
				layer.enabled: true
				layer.effect: FastBlur { radius: 12; }
			}
		}
	}

	Row { id: layout
		visible: activePlayer
		spacing: 2

		// play/pause button
		Item { id: playButton
			anchors.verticalCenter: parent.verticalCenter
			width: button.width
			height: button.height

			IconImage { id: button
				anchors.centerIn: parent
				implicitSize: root.iconSize
				source: activePlayer.isPlaying ? Quickshell.iconPath("player_pause") : Quickshell.iconPath("player_play")
			}

			MouseArea {
				anchors.fill: parent
				onClicked: { activePlayer.isPlaying ? activePlayer.pause() : activePlayer.play(); }
			}
		}

		// display the current track name and artist
		Item { id: currentTrack
			width: (root.trackLength > trackInfo.width) ? trackInfo.width : root.trackLength
			height: artHMask.height

			// clip the track name and artist to user-defined length
			Rectangle { id: infoMask
				anchors.fill: parent
				color: "transparent"
				layer.enabled: true
				layer.effect: OpacityMask {
					maskSource: Rectangle {
						width: infoMask.width
						height: infoMask.height
						gradient: Gradient {
							orientation: Gradient.Horizontal
							GradientStop { position: 0.9; color: "#ff000000" }
							GradientStop { position: 1.0; color: (root.trackLength > trackInfo.width) ? "#ff000000" : "#00000000" }
						}
					}
				}
				clip: true

				Row { id: trackInfo
					anchors.verticalCenter: parent.verticalCenter
					spacing: 2

					Text { id: track
						text: activePlayer.trackTitle
						color: colour
						font { pointSize: fontSize; family: fontFamily; weight: 600; }
					}
					Text { id: seperator
						visible: activePlayer.trackArtist
						text: "•"
						color: colour
						font { pointSize: fontSize; family: fontFamily; }
					}
					Text { id: artist
						text: activePlayer.trackArtist
						color: colourMid
						font { pointSize: fontSize; family: fontFamily; }
					}
					Item { id: spacer; width: 6; height: track.height; }
				}
			}

			// scroll the track info if it's too long to fit
			MouseArea {
				anchors.fill: parent
				hoverEnabled: true

				onEntered: {
					if (trackInfo.width > infoMask.width) {
						const distance = trackInfo.width - infoMask.width
						const speed = root.scrollSpeed
						scrollAnim.duration = (distance / speed) *1000
						scrollAnim.from = 0
						scrollAnim.to = infoMask.width - trackInfo.width
						scrollAnim.running = true
					}
				}

				onExited: {
					scrollAnim.running = false
					trackInfo.x = 0
				}
			}
			NumberAnimation { id: scrollAnim
				target: trackInfo
				property: "x"
				easing.type: Easing.Linear
			}
		}

		// scroll bar showing elapsed track time
		Rectangle { id: scrollBar
			anchors.verticalCenter: parent.verticalCenter
			width: 100
			height: root.scrollbarHeight
			radius: height /2
			border { color: "#60000000"; width: 1; }
			gradient: Gradient {
				orientation: Gradient.Vertical
				GradientStop { position: 0.0; color: "#60000000" }
				GradientStop { position: 1.0; color: "#30000000" }
			}

			Rectangle { id: scrollElapsed
				property int elapsed: scrollBar.width *(activePlayer.position/activePlayer.length);

				width: elapsed < (height) ? height : elapsed
				height: scrollBar.height
				radius: height /2
				color: root.colourBar
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
