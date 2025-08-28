/*-----------------------------------
--- Music player widget by andrel ---
-----------------------------------*/

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import "root:"
import "player"

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

	property bool displayArt: true
	property int trackLength: 200
	property int scrollSpeed: 45
	property int scrollbarHeight: 6
	property int artRadius: 4
	property int iconSize: GlobalConfig.iconSize
	property int padding: GlobalConfig.spacing
	property string colour: GlobalConfig.colour.foreground
	property string barColour: GlobalConfig.colour.accent
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

	RowLayout { id: layout
		visible: activePlayer

		// display the album art when available
		Item { id: albumArt
			visible: root.displayArt

			width: player.height -root.padding
			height: player.height -root.padding

			IconImage { id: placeholderArt
				anchors.centerIn: parent

				implicitSize: root.iconSize
				source: "root:/player/icons/placeholder"
			}
			IconImage { id: trackAlbumArt
				anchors.centerIn: parent

				implicitSize: albumArt.width
				source: activePlayer.trackArtUrl
				layer.enabled: true
				layer.effect: OpacityMask {
					maskSource: Rectangle {
						width: trackAlbumArt.width
						height: trackAlbumArt.height
						radius: root.artRadius
					}
				}
			}

			// play/pause track clicking on track album art
			MouseArea {
				anchors.fill: parent
				hoverEnabled: true

				onClicked: {
					activePlayer.isPlaying ? activePlayer.pause() : activePlayer.play()
				}
			}
		}

		ColumnLayout { id: player
			spacing: -2

			// display the current track name and artist
			Item { id: currentTrack
				width: root.trackLength
				height: trackInfo.height

				// clip the track name and artist to user-defined length
				Rectangle { id: clipper
					anchors.fill: parent
					color: "transparent"
					clip: true

					RowLayout { id: trackInfo
						spacing: 2

						Text { id: track
							text: activePlayer.trackTitle

							color: colour
							verticalAlignment: Text.AlignBottom
							font { pointSize: fontSize; family: fontFamily; weight: 600; }
						}
						Text { id: artist
							text: activePlayer.trackArtist

							color: "#b8c0e0"
							font { pointSize: fontSize; family: fontFamily; }
						}
					}
				}

				// scroll the track info if it's too long to fit
				MouseArea {
					anchors.fill: parent
					hoverEnabled: true

					onEntered: {
						if (trackInfo.width > clipper.width) {
							const distance = trackInfo.width - clipper.width
							const speed = root.scrollSpeed
							scrollAnim.duration = (distance / speed) *1000
							scrollAnim.from = 0
							scrollAnim.to = clipper.width - trackInfo.width
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


			RowLayout {
				spacing: root.padding

				// scroll bar showing elapsed track time
				Rectangle { id: scrollBar
					Layout.fillWidth: true
					height: root.scrollbarHeight
					radius: height /2
					color: "#6e738d"

					Rectangle{
						property int elapsed: scrollBar.width *(activePlayer.position/activePlayer.length);

						width: elapsed < (height) ? height : elapsed
						height: scrollBar.height
						radius: height /2
						color: root.colour
					}
				}

				// elapsed track time/track length
				Text { id: time
					text: formatTime(parseInt(activePlayer.position)) +" / " +formatTime(parseInt(activePlayer.length))

					color: colour
					font { pointSize: 7; family: fontFamily; }
				}
			}
		}
	}
}
