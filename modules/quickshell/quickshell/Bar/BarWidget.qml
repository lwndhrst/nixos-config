import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.Style

WrapperRectangle {
  Layout.fillHeight: true

  color: Style.palette.surface

  radius: Style.baseInnerRadius

  leftMargin: Style.baseMargin
  rightMargin: Style.baseMargin
  topMargin: Style.baseMargin / 2
  bottomMargin: Style.baseMargin / 2
}
