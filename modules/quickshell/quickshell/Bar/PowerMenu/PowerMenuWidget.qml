import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Style

BarTextButton {
  id: root

  property int menuWindowOffset: 0

  textColor: Style.palette.love
  text: "󰐥"

  onClicked: () => {
    menu.visible = !menu.visible
    grab.active = !grab.active
  }

  HyprlandFocusGrab {
    id: grab
    windows: [ menu ]

    onCleared: () => {
      menu.visible = false;
      grab.active = false;
    }
  }

  PanelWindow {
    id: menu

    anchors {
      top: true
      left: true
    }

    margins {
      // left: Style.baseMargin + Style.baseSpacing + root.x
      left: root.menuWindowOffset + root.x - Style.baseMargin / 2
    }

    aboveWindows: true
    visible: false

    color: "transparent"

    implicitWidth: rect.implicitWidth
    implicitHeight: rect.implicitHeight

    WrapperRectangle {
      id: rect

      color: Style.palette.base

      leftMargin: Style.baseMargin / 2
      rightMargin: Style.baseMargin / 2
      bottomMargin: Style.baseMargin / 2

      bottomRightRadius: Style.baseOuterRadius
      bottomLeftRadius: Style.baseOuterRadius

      ColumnLayout {
        spacing: Style.baseSpacing

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
