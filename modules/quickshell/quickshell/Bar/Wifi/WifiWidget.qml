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
        const networks = this.text.split("\n");

        for (const network of networks) {
          const networkInfos = network.split(":");
          const active = networkInfos[0];
          const signal = networkInfos[1];

          if (active == "yes") {
            root.updateText(signal);
            return;
          }
        }

        // No active network
        root.updateText(0);
      }
    }
  }
}
