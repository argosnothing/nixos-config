/*----------------------------------
--- Bluetooth service by andrel ---*
----------------------------------*/

pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton { id: root
	property bool powered
	property bool paired: (devices.length)
	property list<string> devices

	// start bluetooth monitor
	Process {
		running: true
		command: ["bluetoothctl"]
		stdout: SplitParser {
			onRead: {
				blueInfo.running = true
				blueDevices.running = true
			}
		}
	}

	// get bluetooth info
	Process { id: blueInfo
		running: true
		command: ["bluetoothctl", "show"]
		stdout: StdioCollector {
			onStreamFinished: {
				const lines = text.split('\n');
				root.powered = lines.find(line => line.trim().startsWith('Powered:'))?.split(': ')[1] == 'yes' || null;
			}
		}
	}

	// get paired devices
	Process { id: blueDevices
		running: true
		command: ["bluetoothctl", "devices", "Connected"]
		stdout: StdioCollector {
			onStreamFinished: {
				const lines = text.split('\n');
				root.devices = [];
				for (let line of lines) {
					const device = line.match(/^Device\s+[A-F0-9:]+\s+(.+)$/i);
					if (device) {
						root.devices.push(device[1]);
					}
				}
			}
		}
	}
}
