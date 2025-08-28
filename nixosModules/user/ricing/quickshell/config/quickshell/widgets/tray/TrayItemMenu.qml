import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import "root:"

Item { id: root
	required property QsMenuHandle modelData

	property bool isSubMenu: index >0
	property bool hasButton: false
	property bool hasIcon: false
	property bool hasChildren: false

	property int menuMargin: GlobalConfig.spacing

	property string colourAccent: GlobalConfig.colour.accent
	property string colourText: GlobalConfig.colour.foreground
	property string fontFamily: GlobalConfig.font.sans
	property int fontSize: GlobalConfig.font.size

	signal subMenuOpened(QsMenuHandle subMenuHandle)
	signal subMenuClosed()

	width: layout.width
	height: layout.height

	QsMenuAnchor { id: menuAnchor
		anchor.item: root
		menu: root.modelData
	}

	QsMenuOpener { id: menuOpener
		menu: root.modelData
	}

	ColumnLayout { id: layout
		spacing: 2

		// return option for submenus
		Item { id: backArrow
			visible: isSubMenu
			width: backLayout.width +menuMargin *2
			height: backLayout.height
			Layout.fillWidth: true

			Rectangle { id: backHighlighter
				anchors.fill: parent
				radius: 2
				color: colourAccent
				opacity: backMouseArea.containsMouse? 0.5 : 0

				Behavior on opacity { NumberAnimation { duration: 300; }}
			}

			RowLayout { id: backLayout
				anchors{ left: parent.left; leftMargin: menuMargin; }
				spacing: 2

				// reserve space for back arrow
				Item {
					width: backText.height
					height: backText.height
				}

				Text { id: backText
					text: "Back"
					color: colourText
					font{ family: fontFamily; pointSize: fontSize; }
				}
			}

			IconImage {
				implicitSize: backText.height
				source: Quickshell.iconPath("draw-arrow-back")
			}

			MouseArea { id: backMouseArea
				anchors.fill: parent
				hoverEnabled: true
				onClicked: event => {
					subMenuClosed();
				}
			}
		}

		// formatted menu entries
		Repeater {
			model: menuOpener.children

			RowLayout { id: menuEntry
				required property QsMenuHandle modelData

				property bool isSeparator: menuEntry.modelData.isSeparator

				Layout.preferredWidth: entryLayout.width +menuMargin *2

				// set properties that will be used for formatting
				Component.onCompleted: {
					if (menuEntry.modelData.buttonType !== QsMenuButtonType.None) {
						hasButton = true;
					}
					if (menuEntry.modelData.icon) {
						hasIcon = true;
					}
					if (menuEntry.modelData.hasChildren) {
						hasChildren = true;
					}
				}

				Item {
					Layout.fillWidth: true

					visible: !isSeparator
					height: entryLayout.height +2

					Rectangle { id: highlighter
						anchors.fill: parent
						radius: 2
						color: colourAccent
						opacity: mouseArea.containsMouse? 0.5 : 0

						Behavior on opacity { NumberAnimation { duration: 300; }}
					}

					RowLayout { id: entryLayout
						anchors { left: parent.left; leftMargin: menuMargin; verticalCenter: parent.verticalCenter; }
						spacing: 2

						// reserve space for back arrow
						Item {
							visible: isSubMenu
							width: text.height
							height: text.height
						}

						Item { id: button
							visible: hasButton
							width: text.height
							height: text.height

							IconImage { id: checkBox
								visible: modelData.buttonType === QsMenuButtonType.CheckBox
								implicitSize: parent.height
								source: {
									switch (modelData.checkState) {
										case Qt.Checked:
											return Quickshell.iconPath("checkbox-checked-symbolic");
											break;
										case Qt.PartiallyChecked:
											return Quickshell.iconPath("checkbox-mixed-symbolic");
											break
										default:
											return Quickshell.iconPath("checkbox-symbolic");
									}
								}
							}

							IconImage { id: radioButton
								visible: modelData.buttonType === QsMenuButtonType.RadioButton
								implicitSize: parent.height
								source: {
									switch (modelData.checkState) {
										case Qt.Checked:
											return Quickshell.iconPath("radio-checked-symbolic");
											break;
										case Qt.PartiallyChecked:
											return Quickshell.iconPath("radio-mixed-symbolic");
											break
										default:
											return Quickshell.iconPath("radio-symbolic");
									}
								}
							}
						}

						Item { id: icon
							visible: hasIcon
							width: text.height
							height: text.height

							IconImage {
								visible: modelData.icon
								implicitSize: parent.height
								source: modelData.icon
							}
						}

						Text { id: text
							visible: !isSeparator
							text: menuEntry.modelData.text
							color: colourText
							font{ family: fontFamily; pointSize: fontSize; }
						}

						// reserve space for forward arrow
						Item {
							visible: hasChildren
							width: text.height
							height: text.height
						}
					}

					Item { id: forwardArrow
						anchors{ right: parent.right; verticalCenter: parent.verticalCenter; }
						visible: hasChildren
						width: text.height
						height: text.height

						IconImage {
							visible: modelData.hasChildren
							implicitSize: parent.height
							source: Quickshell.iconPath("draw-arrow-forward")
						}
					}

					MouseArea { id: mouseArea
						anchors.fill: parent
						hoverEnabled: true
						onClicked: event => {
							if(modelData.hasChildren){
								subMenuOpened(modelData);
							} else {
								modelData.triggered();
								menuAnchor.open();
								menuAnchor.close();
							}
						}
					}
				}

				Rectangle { id: separator
					Layout.fillWidth: true
					visible: isSeparator
					height: 1
					color: colourText
					opacity: 0.3
				}
			}
		}
	}
}
