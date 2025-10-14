import Quickshell
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.Style
import qs.Widgets

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
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
        spacing: 10

        // left
        WrapperRectangle {
          Layout.alignment: Qt.AlignLeft
          Layout.leftMargin: 20

          color: Style.palette.base

          RowLayout {}
        }

        // center
        WrapperRectangle {
          Layout.alignment: Qt.AlignCenter

          color: Style.palette.base

          RowLayout {}
        }

        // right
        WrapperRectangle {
          Layout.alignment: Qt.AlignRight
          Layout.rightMargin: 20

          color: Style.palette.base

          RowLayout {
            SystemTrayWidget {}
            ClockWidget {}
          }
        }
      }
    }
  }
}
