import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import "root:"

Item { id: root
	required property list<QsMenuHandle> activeMenu

	width: layout.width
	height: layout.height

	RowLayout { id: layout

		Repeater { id: subMenu
			model: activeMenu

			TrayItemMenu { id: menutest
				required property int index

				visible: index === subMenu.count -1

				onSubMenuOpened: activeMenu.push(subMenuHandle)
				onSubMenuClosed: activeMenu.length -=1

				Layout.leftMargin: 6
				Layout.rightMargin: 6
				Layout.topMargin: 6
				Layout.bottomMargin: 6
				Layout.fillHeight: true
			}
		}
	}
}
