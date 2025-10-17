import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

import QtQuick

import qs.Style

PanelWindow {
  id: menu

  required property Item content;

  property int windowOffset: 0
  property bool enableFocusGrab: true

  anchors {
    top: true
    left: true
  }

  margins {
    left: menu.windowOffset - Style.baseMargin / 2
  }

  aboveWindows: true
  visible: false

  color: "transparent"

  implicitWidth: rect.implicitWidth
  implicitHeight: rect.implicitHeight

  WrapperRectangle {
    id: rect

    color: Style.palette.base

    leftMargin: Style.baseSpacing
    rightMargin: Style.baseSpacing
    bottomMargin: Style.baseSpacing

    bottomRightRadius: Style.baseOuterRadius
    bottomLeftRadius: Style.baseOuterRadius

    child: menu.content
  }

  HyprlandFocusGrab {
    id: grab
    windows: [ menu ]

    onCleared: () => {
      menu.visible = false;
      grab.active = false;
    }
  }

  function showMenu() {
    menu.visible = true;
    grab.active = menu.enableFocusGrab;

    // Clamp window offset/size to screen
    menu.windowOffset = Math.min(menu.screen.width - menu.implicitWidth - Style.baseMargin, menu.windowOffset);
  }

  function hideMenu() {
    menu.visible = false;
    grab.active = false;
  }
}
