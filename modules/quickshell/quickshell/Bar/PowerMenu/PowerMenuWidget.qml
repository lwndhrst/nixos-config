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
      left: Style.baseMargin + root.x
    }

    aboveWindows: true
    visible: false

    color: "transparent"

    implicitWidth: rect.implicitWidth
    implicitHeight: rect.implicitHeight

    WrapperRectangle {
      id: rect

      color: Style.palette.base

      leftMargin: Style.baseMargin
      rightMargin: Style.baseMargin
      topMargin: Style.baseMargin / 2
      bottomMargin: Style.baseMargin

      bottomRightRadius: Style.baseOuterRadius
      bottomLeftRadius: Style.baseOuterRadius

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
