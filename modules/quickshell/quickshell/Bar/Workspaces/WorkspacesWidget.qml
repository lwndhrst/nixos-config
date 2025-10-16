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

      var cmd = event.angleDelta.y > 0
        ? "workspace e+1"
        : "workspace e-1";

      Hyprland.dispatch(cmd)
    }

    RowLayout {
      id: row

      Repeater {
        model: Hyprland.workspaces

        WrapperRectangle {
          id: workspace

          Layout.alignment: Qt.AlignCenter

          required property HyprlandWorkspace modelData;

          color: Hyprland.focusedWorkspace?.id == workspace.modelData.id
            ? Style.palette.text
            : Style.palette.highlightHigh

          width: 10
          height: 10
          radius: 5

          WrapperMouseArea {
            anchors.fill: parent

            acceptedButtons: Qt.LeftButton

            onClicked: event => {
              event.accepted = true;
              workspace.modelData.activate();
            }
          }
        }
      }
    }
  }
}
