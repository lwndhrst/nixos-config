import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.Bar
import qs.Bar.Notifications
import qs.Style

BarTextButton {
  id: root

  property int baseMenuWindowOffset: root.parent?.parent != null
    ? root.parent.parent.x
    : 0

  property bool hasNotifications: NotificationManager.notifications.values.length > 0

  textColor: hasNotifications
    ? Style.palette.text
    : Style.palette.subtle

  text: hasNotifications
    ? "󱅫"
    : "󰂚"

  onClicked: () => {
    menu.showMenu()
  }

  BarMenu {
    id: menu

    windowOffset: root.baseMenuWindowOffset + root.x

    content: ClippingRectangle {
      color: Style.palette.base
      radius: Style.baseInnerRadius

      implicitWidth: 400
      implicitHeight: 600

      ColumnLayout {
        spacing: Style.baseSpacing

        Repeater {
          model: NotificationManager.notifications

          NotificationListItem {
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true

            implicitWidth: 400
          }
        }
      }
    }
  }
}
