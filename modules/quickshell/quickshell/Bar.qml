import Quickshell

import QtQuick
import QtQuick.Layouts

import qs.style
import qs.widgets

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

      implicitHeight: 20

      RowLayout {
        anchors.fill: parent

        // left
        RowLayout {
          Layout.alignment: Qt.AlignLeft
        }

        // center
        RowLayout {
          Layout.alignment: Qt.AlignCenter
        }

        // right
        RowLayout {
          Layout.alignment: Qt.AlignRight
          ClockWidget {
            color: Style.palette.text
          }
        }
      }
    }
  }
}
