import Quickshell.Services.Notifications
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Style

WrapperMouseArea {
  id: root

  required property Notification modelData

  property int maxHeight: 200

  hoverEnabled: true

  onEntered: () => {
    dismissButton.visible = true
  }

  onExited: () => {
    dismissButton.visible = false
  }

  Rectangle {
    implicitWidth: notification.implicitWidth
    implicitHeight: notification.implicitHeight < root.maxHeight ? notification.implicitHeight : root.maxHeight

    color: Style.palette.surface
    radius: Style.baseInnerRadius

    WrapperRectangle {
      id: notification

      implicitWidth: root.implicitWidth

      margin: Style.baseMargin
      color: "transparent"

      ColumnLayout {
        spacing: Style.baseSpacing

        Text {
          Layout.alignment: Qt.AlignTop

          color: Style.palette.text
          font: Style.barFont

          text: root.modelData.summary
        }

        Text {
          Layout.alignment: Qt.AlignTop

          color: Style.palette.text
          font: Style.barFont

          text: root.modelData.body
        }
      }
    }

    BarTextButton {
      id: dismissButton

      visible: false

      bgColor: Style.palette.love
      textColor: Style.palette.base
      text: "󰩹"

      anchors {
        top: notification.top
        right: notification.right
      }

      onClicked: () => {
        root.modelData.dismiss()
      }
    }
  }
}
