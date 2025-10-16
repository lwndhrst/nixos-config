import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Style

BarTextButton {
  id: root

  textColor: Style.palette.love
  text: "󰐥"

  onClicked: event => {
    menu.visible = !menu.visible
  }

  PanelWindow {
    id: menu

    anchors {
      top: true
      left: true
    }

    margins {
      left: 8
    }

    aboveWindows: true
    visible: false

    color: "transparent"

    implicitWidth: rect.implicitWidth
    implicitHeight: rect.implicitHeight

    WrapperRectangle {
      id: rect

      color: Style.palette.base

      leftMargin: 8
      rightMargin: 8
      topMargin: 4
      bottomMargin: 8

      bottomRightRadius: 8
      bottomLeftRadius: 8

      RowLayout {
        BarTextButton {
          text: "󰐥"
          textColor: Style.palette.base
          bgColor: Style.palette.love

          onClicked: event => {
            shutdown.startDetached();
          }

          Process {
            id: shutdown
            command: [ "systemctl", "poweroff" ]
          }
        }

        BarTextButton {
          text: "󰜉"
          textColor: Style.palette.base
          bgColor: Style.palette.gold

          onClicked: event => {
            reboot.startDetached();
          }

          Process {
            id: reboot
            command: [ "systemctl", "reboot" ]
          }
        }

        BarTextButton {
          text: "󰤄"
          textColor: Style.palette.base
          bgColor: Style.palette.foam

          onClicked: event => {
            suspend.startDetached();
          }

          Process {
            id: suspend
            command: [ "systemctl", "suspend" ]
          }
        }
      }
    }
  }
}
