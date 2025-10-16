import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Style

BarWidget {
  RowLayout {
    id: row

    IconImage {
      source: Quickshell.iconPath(ToplevelManager.activeToplevel.appId)
      implicitWidth: Style.barIconSize.width
      implicitHeight: Style.barIconSize.height
    }
    
    Text {
      color: Style.palette.text
      font: Style.barFont

      text: ToplevelManager.activeToplevel.title
    }
  }
}
