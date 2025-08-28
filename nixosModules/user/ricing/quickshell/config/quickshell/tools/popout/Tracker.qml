pragma Singleton

import QtQuick
import QtQuick.Controls
import Quickshell

Singleton { id: root
	property bool isMenuOpen: false

	signal isOpened(var menu)
}
