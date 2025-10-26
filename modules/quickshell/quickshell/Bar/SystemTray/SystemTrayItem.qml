import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

import QtQuick
import QtQuick.Controls

import qs.Style

WrapperMouseArea {
  id: root

  required property SystemTrayItem modelData

  required property PanelWindow bar

  property int baseMenuWindowOffset: 0

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  cursorShape: Qt.PointingHandCursor

  acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

  onClicked: event => {
    event.accepted = true;

    if (event.button == Qt.LeftButton) {
      root.modelData.activate();
      return;
    }

    if (event.button == Qt.MiddleButton) {
      root.modelData.secondaryActivate();
      return;
    }

    if (event.button == Qt.RightButton && root.modelData.hasMenu) {
      root.modelData.display(bar, root.baseMenuWindowOffset + root.x, bar.implicitHeight);
      return;
    }
  }

  // Hijacking button icon property for recoloring icons
  Button {
    id: button

    anchors.centerIn: parent

    background: Item {}
    enabled: false

    padding: 0

    icon.source: root.modelData.icon
    icon.width: Style.barIconSize.width
    icon.height: Style.barIconSize.height
    icon.color: Style.palette.text
  }
}
