import ../constants
import ../util
from types import Ui

from nimraylib_now import Vector2, drawRectangleLines

proc toggleSettings*(ui: Ui) =
  ui.showSettings = not ui.showSettings

proc drawSettings*(ui: Ui) =
  let
    popupSize = Vector2(
        x: 300,
        y: 600)
    popupTopLeft = Vector2(
        x: ScreenWidth.float - margin,
        y: 10)
  drawRectangleLines(
      popupTopLeft,
      popupSize,
      borderColor)

