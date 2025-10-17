import Quickshell.Io

import QtQuick

import qs.Bar
import qs.Style

BarTextButton {
  id: root

  textColor: Style.palette.gold
  text: "󰤫";

  function updateText(signal) {
    if (signal == 0) {
      root.text = "󰤮";
      return;
    }

    if (signal < 20) {
      root.text = "󰤯";
      return;
    }

    if (signal < 40) {
      root.text = "󰤟";
      return;
    }

    if (signal < 60) {
      root.text = "󰤢";
      return;
    }

    if (signal < 80) {
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
      getWifiInfoProcess.exec({});
    }
  }

  Process {
    id: getWifiInfoProcess

    command: [ "nmcli", "-g", "ACTIVE,SIGNAL", "d", "wifi" ]

    stdout: StdioCollector {
      onStreamFinished: () => {
        const networkInfos = this.text.split("\n");

        for (const info of networkInfos) {
          const properties = info.split(":");

          const active = properties[0];
          const signal = properties[1];

          if (active == "yes") {
            root.updateText(signal);
            return;
          }
        }

        // No active wifi connection
        root.updateText(0);
      }
    }
  }
}
