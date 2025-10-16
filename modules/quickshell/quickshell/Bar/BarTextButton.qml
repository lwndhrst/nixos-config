import Quickshell.Widgets

import QtQuick

import qs.Style

WrapperMouseArea {
  id: root

  required property string text

  property color textColor: Style.palette.text
  property int textPixelSize: 18

  cursorShape: Qt.OpenHandCursor

  BarWidget {
    topMargin: 0
    bottomMargin: 0

    Text {
      color: root.textColor
      font.pixelSize: root.textPixelSize
      verticalAlignment: Text.AlignVCenter
      horizontalAlignment: Text.AlignHCenter

      text: root.text
    }
  }
}
