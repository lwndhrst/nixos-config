import Quickshell.Io

import QtQuick

import qs.Bar
import qs.Style

BarTextButton {
  id: root

  textColor: Style.palette.gold
  text: "󰤥"

  function updateText(linkQualityPercent) {
    if (linkQualityPercent < 0.01) {
      root.text = "󰤮";
      return;
    }

    if (linkQualityPercent < 0.2) {
      root.text = "󰤯";
      return;
    }

    if (linkQualityPercent < 0.4) {
      root.text = "󰤟";
      return;
    }

    if (linkQualityPercent < 0.6) {
      root.text = "󰤢";
      return;
    }

    if (linkQualityPercent < 0.8) {
      root.text = "󰤥";
      return;
    }

    root.text = "󰤨";
  }

  Timer {
    id: timer

    interval: 10000
    triggeredOnStart: true
    running: true
    repeat: true

    onTriggered: () => {
      process.exec({});
    }
  }

  Process {
    id: process

    command: [ "iwconfig" ]

    stdout: StdioCollector {
      onStreamFinished: () => {
        var text = this.text;

        text = text.substring(text.indexOf("Link Quality"));
        text = text.substring(text.indexOf("=") + 1);
        text = text.split(" ")[0];
        text = text.split("/");

        // Implicitly cast to float because JS magic?
        root.updateText(text[0] / text[1]);
      }
    }
  }
}
