import Quickshell.Widgets

import QtQuick

import qs.Singletons
import qs.Style

WrapperRectangle {
  id: root

  color: Style.palette.surface
  default property color textColor: Style.palette.text

  Text {
    color: root.textColor
    text: Time.time
  }
}
