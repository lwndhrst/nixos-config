import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.Style

WrapperRectangle {
  id: root

  RowLayout {
    id: row

    spacing: 10

    Repeater {
      model: SystemTray.items

      Text {
        id: item

        required property SystemTrayItem modelData;

        text: item.modelData.id
      }
    }
  }
}
