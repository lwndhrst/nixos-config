import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

import QtQuick

import qs.Style

PanelWindow {
  id: toplevel

  required property Item content;

  property int windowOffset: 0
  property bool enableFocusGrab: true

  anchors {
    left: true
    top: true
    right: true
  }

  implicitHeight: 0

  aboveWindows: true
  visible: false

  color: "transparent"

  PopupWindow {
    id: menu

    color: "transparent"

    anchor.window: toplevel
    anchor.rect.x: toplevel.windowOffset - Style.baseMargin / 2
    anchor.rect.y: 0

    implicitWidth: rect.implicitWidth
    implicitHeight: rect.implicitHeight

    visible: false

    WrapperRectangle {
      id: rect

      color: Style.palette.base

      leftMargin: Style.baseSpacing
      rightMargin: Style.baseSpacing
      bottomMargin: Style.baseSpacing

      bottomRightRadius: Style.baseOuterRadius
      bottomLeftRadius: Style.baseOuterRadius

      child: toplevel.content
    }

    HyprlandFocusGrab {
      id: grab
      windows: [ menu ]

      onCleared: () => {
        menu.visible = false;
        grab.active = false;
      }
    }
  }

  function showMenu() {
    // Clamp window position to screen (respecting base margins)
    const maxOffset = menu.screen.width - menu.implicitWidth - Style.baseMargin - Style.baseSpacing;
    const windowOffset = toplevel.windowOffset - Style.baseMargin / 2;
    menu.anchor.rect.x = Math.min(maxOffset, windowOffset);

    toplevel.visible = true;
    menu.visible = true;
    grab.active = toplevel.enableFocusGrab;
  }

  function hideMenu() {
    toplevel.visible = false;
    menu.visible = false;
    grab.active = false;
  }
}
