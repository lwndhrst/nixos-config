pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Bar.SystemTray

BarWidget {
  id: root

  required property PanelWindow bar

  property int baseMenuWindowOffset: root.parent?.parent != null
    ? root.parent.parent.x
    : 0

  RowLayout {
    id: row

    spacing: 8

    Repeater {
      id: repeater

      model: SystemTray.items

      SystemTrayItem {
        bar: root.bar
        baseMenuWindowOffset: root.baseMenuWindowOffset
      }
    }
  }
}
