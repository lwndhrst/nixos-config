import Quickshell

import QtQuick

import qs.Bar
import qs.Style

BarWidget {
  Text {
    color: Style.palette.text
    font: Style.barFont
    verticalAlignment: Text.AlignVCenter

    text: Qt.formatDateTime(clock.date, "ddd MMM d | hh:mm:ss")

    SystemClock {
      id: clock
      precision: SystemClock.Seconds
    }
  }
}
