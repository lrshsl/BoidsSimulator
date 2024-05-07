import ../constants
import ../util
from draw_widget import draw
from types import Ui, Widget

import nimraylib_now

import sugar

var
  clicklessUi* = clicklessUiDefault
  showSliderName* = showSliderNameDefault
  showSliderValue* = showSliderValueDefault
  debugMode* = debugModeDefault

proc createDefaultToggleButton(
    name: string,
    pos: Vector2,
    defaultState: bool,
    callback: proc (ui: Ui)): Widget =
  Widget(
      kind: ToggleButton,
      pos: pos,
      size: defaultButtonSize(),
      bgColor: bgColor,
      borderColor: borderColor,
      buttonText: name,
      textColor: textColor,
      onClick: callback,
      onRelease: callback,
      isBeingClicked: not defaultState)

proc settingsContent*(): seq[Widget] =
  let
    debugModeButton = createDefaultToggleButton(
      "Debug mode",
      popupTopLeft() + Vector2(
        x: margin,
        y: margin),
      debugMode,
      proc (ui: Ui) = debugMode = not debugMode
    )

    clicklessUiButton = createDefaultToggleButton(
      "Clickless UI",
      popupTopLeft() + Vector2(
        x: margin,
        y: margin + (defaultButtonSize().y + margin) * 2),
      clicklessUi,
      proc (ui: Ui) = clicklessUi = not clicklessUi
    )

    showSliderNameButton = createDefaultToggleButton(
      "Slider name",
      popupTopLeft() + Vector2(
        x: margin,
        y: margin + (defaultButtonSize().y + margin) * 3),
      showSliderName,
      proc (ui: Ui) = showSliderName = not showSliderName
    )

    showSliderValueButton = createDefaultToggleButton(
      "Slider value",
      popupTopLeft() + Vector2(
        x: margin,
        y: margin + (defaultButtonSize().y + margin) * 4),
      showSliderValue,
      proc (ui: Ui) = showSliderValue = not showSliderValue
    )

  return @[debugModeButton,
    clicklessUiButton,
    showSliderNameButton,
    showSliderValueButton]

proc toggleSettingsPopup*(ui: Ui) =
  ui.showSettings = not ui.showSettings

proc drawSettingsPopup*(ui: Ui) =
  drawRectangleLines(
      popupTopLeft(),
      popupSize(),
      borderColor)
  for wg in ui.settingsContent:
    ui.draw(wg)

proc updateSettings*(ui: Ui) =
  discard

