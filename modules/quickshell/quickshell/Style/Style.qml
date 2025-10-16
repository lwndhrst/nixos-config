pragma Singleton

import Quickshell

import QtQuick

Singleton {
  readonly property Colors palette: Colors {}

  readonly property font barFont: ({
    family: "Cascadia Code",
    pixelSize: 12
  })

  readonly property size barIconSize: ({
    width: 12,
    height: 12
  })
}
