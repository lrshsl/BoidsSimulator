import ../constants
import ../util
from draw_widget import draw
from types import Ui, Widget

import nimraylib_now

var
  clicklessUi* = true
  showSliderName* = true
  showSliderValue* = true

proc toggleClicklessUi(_: Ui) = clicklessUi = not clicklessUi

proc toggleShowSliderName(_: Ui) = showSliderName = not showSliderName

proc toggleShowSliderValue(_: Ui) = showSliderValue = not showSliderValue

let
  clicklessUiButton = Widget(
      kind: ToggleButton,
      pos: popupTopLeft + Vector2(x: margin, y: margin),
      size: defaultButtonSize,
      bgColor: bgColor,
      borderColor: borderColor,
      buttonText: "Clickless UI",
      textColor: textColor,
      onClick: toggleClicklessUi,
      onRelease: toggleClicklessUi,
      isBeingClicked: clicklessUi)

  showSliderNameButton = Widget(
      kind: ToggleButton,
      pos: popupTopLeft + Vector2(
        x: margin,
        y: margin + defaultButtonSize.y + margin),
      size: defaultButtonSize,
      bgColor: bgColor,
      borderColor: borderColor,
      buttonText: "Slider name",
      textColor: textColor,
      onClick: toggleShowSliderName,
      onRelease: toggleShowSliderName,
      isBeingClicked: showSliderName)

  showSliderValueButton = Widget(
      kind: ToggleButton,
      pos: popupTopLeft + Vector2(
        x: margin,
        y: margin * 2 + defaultButtonSize.y * 2 + margin),
      size: defaultButtonSize,
      bgColor: bgColor,
      borderColor: borderColor,
      buttonText: "Slider value",
      textColor: textColor,
      onClick: toggleShowSliderValue,
      onRelease: toggleShowSliderValue,
      isBeingClicked: showSliderValue)

var
  settingsWidgets*: seq[Widget] = @[
      clicklessUiButton,
      showSliderNameButton,
      showSliderValueButton]

proc toggleSettings*(ui: Ui) =
  ui.showSettings = not ui.showSettings

proc drawSettings*(ui: Ui) =
  drawRectangleLines(
      popupTopLeft,
      popupSize,
      borderColor)
  for wg in settingsWidgets:
    ui.draw(wg)

proc updateSettings*(ui: Ui) =
  discard

