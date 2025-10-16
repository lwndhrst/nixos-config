import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Style

BarTextButton {
  id: root

  property int baseMenuWindowOffset: 0

  textColor: Style.palette.love
  text: "󰐥"

  onClicked: () => {
    menu.showMenu()
  }

  BarMenu {
    id: menu

    windowOffset: root.baseMenuWindowOffset + root.x

    content: ColumnLayout {
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
