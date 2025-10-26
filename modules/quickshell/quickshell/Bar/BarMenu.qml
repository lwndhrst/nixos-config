import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

import QtQuick

import qs.Style

PopupWindow {
  id: root

  required property Item menu;

  property int horizontalOffset: 0
  property bool enableFocusGrab: true

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

    child: root.menu
  }

  HyprlandFocusGrab {
    id: grab
    windows: [ root ]

    onCleared: () => {
      root.visible = false;
      grab.active = false;
    }
  }

  function showMenu() {
    // Clamp window position to screen (respecting base margins)
    const maxOffset = root.screen.width - root.implicitWidth - Style.baseMargin - Style.baseSpacing;
    const horizontalOffset = root.horizontalOffset - Style.baseMargin / 2
    root.anchor.rect.x = Math.min(maxOffset, horizontalOffset);

    root.visible = true;
    grab.active = root.enableFocusGrab;
  }

  function hideMenu() {
    root.visible = false;
    grab.active = false;
  }
}
