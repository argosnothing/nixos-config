/*----------------------------------------
--- Niri workspaces service by andrel ---*
----------------------------------------*/

pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton { id: root
	property int numSpaces
	property int currentSpaces

	Process {
		running: true
		command: ["niri", "msg", "event-stream"]
		stdout: SplitParser {
			splitMarker: "Workspace"
			onRead: getWorkspace.running = true
		}
	}

	Process { id: getWorkspace
		running: true
		command: ["niri", "msg", "workspaces"]
		stdout: StdioCollector {
			onStreamFinished: {
				root.numSpaces = parseInt((text.trim().split('\n').pop()).match(/\d+/)?.[0], 10);
				root.currentSpaces = parseInt((text.split('\n').find(line => line.includes('*'))).match(/\d+/)?.[0], 10);
			}
		}
	}
}
