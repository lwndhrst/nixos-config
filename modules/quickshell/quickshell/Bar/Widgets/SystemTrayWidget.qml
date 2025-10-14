import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.Style

WrapperRectangle {
  id: root

  color: Style.palette.surface

  RowLayout {
    id: row

    spacing: 10

    Repeater {
      model: SystemTray.items

      // TODO: Reusable component for tray items and bar buttons in general
      Image {
        id: item

        required property SystemTrayItem modelData;

        source: item.modelData.icon
        sourceSize.width: 20
        sourceSize.height: 20
        cache: false
      }
    }
  }
}
