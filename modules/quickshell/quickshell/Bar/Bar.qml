import Quickshell

import QtQuick
import QtQuick.Layouts

import qs.Style
import qs.Bar
import qs.Bar.Audio
import qs.Bar.Bluetooth
import qs.Bar.Clock
import qs.Bar.Notifications
import qs.Bar.PowerMenu
import qs.Bar.SystemTray
import qs.Bar.Wifi
import qs.Bar.Workspaces

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar

      required property var modelData
      screen: modelData

      color: Style.palette.base

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: row.implicitHeight + 10

      RowLayout {
        id: row

        anchors.fill: parent

        // left
        BarWidgetGroup {
          Layout.alignment: Qt.AlignLeft
          Layout.leftMargin: Style.baseMargin * 2

          RowLayout {
            PowerMenuWidget {}
            WorkspacesWidget {}
          }
        }

        // right
        BarWidgetGroup {
          Layout.alignment: Qt.AlignRight
          Layout.rightMargin: Style.baseMargin * 2

          RowLayout {
            AudioWidget {}
            WifiWidget {}
            BluetoothWidget {}
            SystemTrayWidget {}
            ClockWidget {}
            NotificationsWidget {}
          }
        }
      }
    }
  }
}
