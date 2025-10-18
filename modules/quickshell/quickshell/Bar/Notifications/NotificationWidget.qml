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
      id: menuContent

      color: Style.palette.base
      radius: Style.baseInnerRadius

      implicitWidth: 400
      implicitHeight: 600

      ColumnLayout {
        spacing: Style.baseSpacing

        Rectangle {
          id: menuHeader

          color: "transparent"

          implicitWidth: menuContent.implicitWidth
          implicitHeight: menuTitle.implicitHeight

          WrapperRectangle {
            id: menuTitle

            color: Style.palette.surface
            radius: Style.baseInnerRadius
            margin: Style.baseMargin

            implicitWidth: menuContent.implicitWidth - dismissAllButton.implicitWidth - Style.baseSpacing

            Text {
              font: Style.barFont
              color: Style.palette.text

              text: "Notifications"
            }
          }

          BarTextButton {
            id: dismissAllButton

            anchors.left: menuTitle.right
            anchors.leftMargin: Style.baseSpacing

            implicitHeight: menuTitle.implicitHeight

            textPixelSize: Style.barFont.pixelSize
            textColor: Style.palette.love
            bgColor: Style.palette.surface

            text: "Dismiss all"

            onClicked: NotificationManager.dismissAll()
          }
        }

        Repeater {
          model: NotificationManager.notifications

          implicitWidth: menuContent.implicitWidth

          NotificationListItem {
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true

            implicitWidth: parent.implicitWidth
          }
        }
      }
    }
  }
}
