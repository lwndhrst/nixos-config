import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

import QtQuick

import qs.Style

WrapperRectangle {
  id: item

  required property SystemTrayItem modelData

  color: "transparent"

  implicitWidth: mouseArea.implicitWidth
  implicitHeight: mouseArea.implicitHeight

  WrapperMouseArea {
    id: mouseArea

    anchors.fill: parent

    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
    cursorShape: Qt.OpenHandCursor

    onClicked: event => {
      event.accepted = true;

      if (event.button == Qt.LeftButton) {
        item.modelData.activate();
      }

      if (event.button == Qt.MiddleButton) {
        item.modelData.secondaryActivate();
      }
    }

    onPressed: event => {
      event.accepted = true;

      if (event.button == Qt.RightButton && item.modelData.hasMenu) {
        // TODO: Show system tray item menu
      }
    }

    IconImage {
      source: item.modelData.icon
      implicitWidth: Style.barIconSize.width
      implicitHeight: Style.barIconSize.height
    }
  }
}
