import Quickshell.Services.Pipewire

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Style

RowLayout {
  id: root

  property int baseMenuWindowOffset: root.parent?.parent != null
    ? root.parent.parent.x
    : 0

  property PwNode input: null
  property PwNode output: null

  property var volumeChange: 0.05

  spacing: Style.baseSpacing

  BarTextButton {
    id: inputButton

    textColor: Style.palette.iris
    text: "󰍬"

    hoverEnabled: true

    function updateText() {
      if (root.input.audio.muted) {
        inputButton.text = "󰍭";
        return;
      }

      inputButton.text = "󰍬";
    }

    onClicked: () => {
      root.input.audio.muted = !root.input.audio.muted;
      updateText();
    }

    onEntered: () => {
      inputMenu.showMenu();
    }

    onExited: () => {
      inputMenu.hideMenu();
    }

    onWheel: event => {
      event.accepted = true;

      if (event.angleDelta.y > 0) {
        root.input.audio.volume = Math.min(root.input.audio.volume + root.volumeChange, 1.0);
      }
      else {
        root.input.audio.volume = Math.max(root.input.audio.volume - root.volumeChange, 0.0);
      }
    }

    BarMenu {
      id: inputMenu

      windowOffset: root.baseMenuWindowOffset + inputButton.x
      enableFocusGrab: false

      content: Rectangle {
        implicitWidth: inputButton.implicitWidth
        implicitHeight: 100

        color: Style.palette.surface
        radius: Style.baseInnerRadius

        Rectangle {
          anchors.bottom: parent.bottom

          implicitWidth: inputButton.implicitWidth
          implicitHeight: calcVolumeBarHeight()

          color: inputButton.textColor
          radius: Style.baseInnerRadius

          function calcVolumeBarHeight() {
            return Math.min(100 * root.input?.audio?.volume, 100);
          }
        }
      }
    }
  }

  BarTextButton {
    id: outputButton

    textColor: Style.palette.love
    text: "󰕾"

    hoverEnabled: true

    function updateText() {
      if (root.output.audio.muted) {
        outputButton.text = "󰝟";
        return;
      }

      if (root.output.audio.volume < 0.33) {
        outputButton.text = "󰕿";
        return;
      }

      if (root.output.audio.volume < 0.66) {
        outputButton.text = "󰖀";
        return;
      }

      outputButton.text = "󰕾";
    }

    onClicked: () => {
      root.output.audio.muted = !root.output.audio.muted;
      updateText();
    }

    onEntered: () => {
      outputMenu.showMenu();
    }

    onExited: () => {
      outputMenu.hideMenu();
    }

    onWheel: event => {
      event.accepted = true;

      if (event.angleDelta.y > 0) {
        root.output.audio.volume = Math.min(root.output.audio.volume + root.volumeChange, 1.0);
      }
      else {
        root.output.audio.volume = Math.max(root.output.audio.volume - root.volumeChange, 0.0);
      }
    }

    BarMenu {
      id: outputMenu

      windowOffset: root.baseMenuWindowOffset + outputButton.x
      enableFocusGrab: false

      content: Rectangle {
        implicitWidth: outputButton.implicitWidth
        implicitHeight: 100

        color: Style.palette.surface
        radius: Style.baseInnerRadius

        Rectangle {
          anchors.bottom: parent.bottom

          implicitWidth: outputButton.implicitWidth
          implicitHeight: calcVolumeBarHeight()

          color: outputButton.textColor
          radius: Style.baseInnerRadius

          function calcVolumeBarHeight() {
            return Math.min(100 * root.output?.audio?.volume, 100);
          }
        }
      }
    }
  }

  onInputChanged: () => {
    boundInputs.objects = [ root.input ];
  }

  PwObjectTracker {
    id: boundInputs
  }

  onOutputChanged: () => {
    boundOutputs.objects = [ root.output ];
  }

  PwObjectTracker {
    id: boundOutputs
  }

  Timer {
    id: timer

    interval: 500
    running: true
    repeat: true

    onTriggered: () => {
      if (Pipewire.ready) {
        root.input = Pipewire.defaultAudioSource;
        root.output = Pipewire.defaultAudioSink;

        inputButton.updateText();
        outputButton.updateText();
      }
    }
  }
}
