pragma Singleton

import Quickshell

import QtQuick

Singleton {
  readonly property Colors palette: Colors {}

  readonly property int baseMargin: 8
  readonly property int baseSpacing: 4

  readonly property int baseOuterRadius: 8
  readonly property int baseInnerRadius: 4

  readonly property font barFont: ({
    family: "Cascadia Code",
    pixelSize: 12
  })

  readonly property size barIconSize: ({
    width: 12,
    height: 12
  })
}
