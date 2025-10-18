import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.Style

WrapperMouseArea {
  id: root

  Layout.fillHeight: true

  required property string text

  property string fontFamily: Style.barFont.family
  property color textColor: Style.palette.text
  property int textPixelSize: 18

  property color bgColor: Style.palette.surface

  cursorShape: Qt.OpenHandCursor

  BarWidget {
    color: root.bgColor

    anchors.fill: parent

    topMargin: 0
    bottomMargin: 0

    Text {
      color: root.textColor
      font.family: root.fontFamily
      font.pixelSize: root.textPixelSize
      verticalAlignment: Text.AlignVCenter
      horizontalAlignment: Text.AlignHCenter

      text: root.text
    }
  }
}
