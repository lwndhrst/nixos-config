import Quickshell.Services.Notifications
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Style

BarTextButton {
  id: root

  property int baseMenuWindowOffset: root.parent?.parent != null
    ? root.parent.parent.x
    : 0

  textColor: Style.palette.subtle
  text: "󰂚"

  onClicked: () => {
    menu.showMenu()
  }

  BarMenu {
    id: menu

    windowOffset: root.baseMenuWindowOffset + root.x

    content: WrapperRectangle {
      color: Style.palette.surface
      radius: Style.baseInnerRadius

      implicitWidth: 300
      implicitHeight: 500

      ColumnLayout {
        anchors.fill: parent
        spacing: Style.baseSpacing

        Repeater {
          model: server.trackedNotifications

          // TODO: Properly build notification list
          Item {
            id: notification

            required property Notification modelData

            Text {
              text: "Hey"
            }
          }
        }
      }
    }
  }

  NotificationServer {
    id: server
    onNotification: notification => {
      notification.tracked = true
    }
  }
}
