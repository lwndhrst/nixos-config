pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

import QtQuick

Singleton {
  id: root

  property alias notifications: server.trackedNotifications

  function dismissAll() {
    while (root.notifications.values.length > 0) {
      root.notifications.values[0].dismiss();
    }
  }

  NotificationServer {
    id: server

    // persistenceSupported: true
    // bodyMarkupSupported: true
    // bodyImagesSupported: true
    // bodyHyperlinksSupported: true
    actionsSupported: true // apparently need this for thunderbird notifications to show up
    // actionIconsSupported: true
    // imageSupported: true

    onNotification: notification => {
      notification.tracked = true;
    }
  }
}
