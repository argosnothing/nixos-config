import QtQuick
import QtQuick.Controls
import Quickshell
import "root:"
import "popout"

Item { id: root
	required property Item anchor
	required property Item content

	readonly property bool isMenuOpen: Tracker.isMenuOpen

	property bool debug: false

	property int margins: GlobalConfig.spacing
	property int cornerRadius: GlobalConfig.cornerRadius

	Connections {
		target: Tracker
		function onIsOpened() {
			if(menu !== root.content)
				root.close()
		}
	}

	anchors.fill: anchor

	Rectangle {
		anchors.fill: parent
		color: "#8000ff00"
		visible: debug
	}

	PopupWindow { id: window
		anchor {
			item: root
			rect{ x: 0; y: GlobalConfig.barHeight -(GlobalConfig.barHeight -root.height) /2 +margins; }
			onAnchoring: { window.anchor.rect.x = root.width /2 -width /2; }
		}

		implicitWidth: menu.width
		implicitHeight: menu.height
		color: debug? "#80ff0000" : "transparent"
		visible: false

		Rectangle { id: menu
			width: content.width
			height: content.height
			color: debug? "#800000ff" : GlobalConfig.colour.background
			radius: cornerRadius
			clip: true

			Behavior on width { NumberAnimation{ id: widthAnim; duration: 750; easing.type: Easing.OutCirc; }}
			Behavior on height { NumberAnimation{ id: heightAnim; duration: 750; easing.type: Easing.OutCirc; }}
		}
	}

	function open() {
		Tracker.isOpened(root.content);
		Tracker.isMenuOpen = true;
		menu.height = cornerRadius *2;
		window.visible = true;
		window.anchor.updateAnchor();
		menu.height = content.height;
		content.y = 0
	}
	function close() {
		Tracker.isMenuOpen = false;
		window.visible = false;
		menu.height = cornerRadius *2;
		content.y = -content.height
	}
	function closeAll() {
		Tracker.isOpened(null);
	}

	Component.onCompleted: {
		content.parent = menu;
		content.y = -content.height
		// content.anchors.bottom = menu.bottom;
		closeAll();
	}
}
