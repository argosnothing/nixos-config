/*----------------------------
--- Clock widget by andrel ---
----------------------------*/

import QtQuick
import Quickshell
import "root:"
import "clock"


MouseArea { id: root
	property string dateFormat: "MM dd yyyy"
	property string timeFormat: "hh:mm:ss a"
	property string colour: GlobalConfig.colour.foreground
	property string fontFamily: GlobalConfig.font.sans
	property int fontSize: GlobalConfig.font.size
	property int fontWeight: GlobalConfig.font.semibold

	implicitWidth: layout.width
	implicitHeight: layout.height

	Row { id: layout
		spacing: 0

		Text { id: date
			height: layout.height
			verticalAlignment: Qt.AlignVCenter
			text: Time.format(dateFormat)
			color: "#b8c0e0"
			font { pointSize: fontSize; family: fontFamily; }
		}
		Text { id: time
			text: Time.format(timeFormat)
			color: colour
			font { pointSize: fontSize; family: fontFamily; weight: fontWeight; }
		}
	}
}
