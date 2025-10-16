import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Style

BarTextButton {
  id: root

  property int menuWindowOffset: 0

  textColor: Style.palette.iris
  text: "󰂚"

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
        }

        BarTextButton {
          text: "󰜉"
          textColor: Style.palette.base
          bgColor: Style.palette.gold
        }

        BarTextButton {
          text: "󰤄"
          textColor: Style.palette.base
          bgColor: Style.palette.foam
        }
      }
    }
  }
}
