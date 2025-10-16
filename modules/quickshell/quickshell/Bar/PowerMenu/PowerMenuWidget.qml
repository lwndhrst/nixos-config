import QtQuick

import qs.Bar
import qs.Style

BarTextButton {
  textColor: Style.palette.gold
  text: "󰐥"

  onClicked: event => {
    console.log("hey");
  }
}
