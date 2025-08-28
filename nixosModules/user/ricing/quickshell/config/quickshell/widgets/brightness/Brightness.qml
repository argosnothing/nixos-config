pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton { id: root
	property int maxBright
	property int currentBright

	Process {
		running: true
		command: ["brightnessctl"]
		stdout: SplitParser {
			onRead: {
				getMax.running = true;
				getCurrent.running = true;
			}
		}
	}

	Process { id: getMax
		running: true
		command: ["brightnessctl", "max"]
		stdout: StdioCollector {
			onStreamFinished: root.maxBright = text
		}
	}

	Process { id: getCurrent
		running: true
		command: ["brightnessctl", "get"]
		stdout: StdioCollector {
			onStreamFinished: {
				root.currentBright = text
			}
		}
	}

	Timer {
		running: true
		repeat: true
		interval: 100
		onTriggered: getCurrent.running = true
	}
}
