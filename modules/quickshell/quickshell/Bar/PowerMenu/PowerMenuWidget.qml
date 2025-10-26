import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Style

BarTextButton {
  id: root

  required property PanelWindow bar

  property int baseMenuWindowOffset: root.parent?.parent != null
    ? root.parent.parent.x
    : 0

  textColor: Style.palette.love
  text: "󰐥"

  onClicked: () => {
    menu.showMenu()
  }

  BarMenu {
    id: menu

    anchor.window: root.bar
    anchor.rect.y: root.bar.implicitHeight

    horizontalOffset: root.baseMenuWindowOffset + root.x

    menu: ColumnLayout {
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
