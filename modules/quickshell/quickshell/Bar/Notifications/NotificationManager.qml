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
    // bodySupported: true
    // bodyMarkupSupported: true
    // bodyImagesSupported: true
    // bodyHyperlinksSupported: true
    // actionsSupported: true
    // actionIconsSupported: true
    // imageSupported: true

    onNotification: notification => {
      notification.tracked = true;
    }
  }
}
