import Quickshell.Hyprland
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Style

BarWidget {
  WrapperMouseArea {
    anchors.fill: parent

    leftMargin: Style.baseMargin
    rightMargin: Style.baseMargin

    implicitWidth: row.implicitWidth

    onWheel: event => {
      event.accepted = true;

      var workspace = event.angleDelta.y > 0
        ? '"e+1"'
        : '"e-1"';

      Hyprland.dispatch("hl.dsp.focus({ workspace = " + workspace + " })");
    }

    RowLayout {
      id: row

      Repeater {
        model: Hyprland.workspaces

        WrapperMouseArea {
          id: workspace

          Layout.alignment: Qt.AlignCenter

          required property HyprlandWorkspace modelData;

          acceptedButtons: Qt.LeftButton

          onClicked: event => {
            event.accepted = true;
            workspace.modelData.activate();
          }

          WrapperRectangle {
            color: Hyprland.focusedWorkspace?.id == workspace.modelData.id
              ? Style.palette.text
              : Style.palette.muted

            implicitWidth: 10
            implicitHeight: 10
            radius: 5
          }
        }
      }
    }
  }
}
