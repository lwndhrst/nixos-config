import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Bar.SystemTray

BarWidget {
  RowLayout {
    id: row

    spacing: 8

    Repeater {
      model: SystemTray.items

      SystemTrayItem {}
    }
  }
}
