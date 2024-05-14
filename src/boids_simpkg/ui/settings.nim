import ../constants
import ../util
from draw_widget import draw
from types import Ui, Widget

import nimraylib_now

var
  ## Shouldn't directly be read usually, but accessor functions should be used
  clicklessUi* = clicklessUiDefault
  showSliderName* = showSliderNameDefault
  showSliderValue* = showSliderValueDefault
  debugMode* = debugModeDefault
  pictureMode* = pictureModeDefault

proc createButton(
    name: string,
    pos: Vector2,
    defaultState: bool,
    callback: proc (ui: Ui)): Widget =
  Widget(
      kind: Button,
      pos: pos,
      size: defaultButtonSize(),
      bgColor: bgColor,
      borderColor: borderColor,
      buttonText: name,
      textColor: textColor,
      onClick: callback,
      onRelease: callback,
      isBeingClicked: not defaultState)

proc createToggleButton(
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
  ## Create all the widgets for the settings popup

  let
    debugModeButton = createToggleButton(
        "Debug mode",
        popupTopLeft() + Vector2(
          x: margin,
          y: margin),
        debugMode,
        proc (ui: Ui) = debugMode = not debugMode)

    clicklessUiButton = createToggleButton(
        "Clickless UI",
        popupTopLeft() + Vector2(
          x: margin,
          y: margin + (defaultButtonSize().y + margin) * 2),
        clicklessUi,
        proc (ui: Ui) = clicklessUi = not clicklessUi)

    showSliderNameButton = createToggleButton(
        "Slider name",
        popupTopLeft() + Vector2(
          x: margin,
          y: margin + (defaultButtonSize().y + margin) * 3),
        showSliderName,
        proc (ui: Ui) = showSliderName = not showSliderName)

    showSliderValueButton = createToggleButton(
        "Slider value",
        popupTopLeft() + Vector2(
          x: margin,
          y: margin + (defaultButtonSize().y + margin) * 4),
        showSliderValue,
        proc (ui: Ui) = showSliderValue = not showSliderValue)

    pictureModeButton = createButton(
        "Hide All",
        popupTopLeft() + Vector2(
          x: margin,
          y: margin + (defaultButtonSize().y + margin) * 5),
        showSliderValue,
        proc (ui: Ui) = pictureMode = not pictureMode)

  return @[debugModeButton,
           clicklessUiButton,
           showSliderNameButton,
           showSliderValueButton,
           pictureModeButton]

proc toggleSettingsPopup*(ui: Ui) =
  ## Open and close the settings popup
  ui.showSettings = not ui.showSettings

proc drawSettingsPopup*(ui: Ui) =
  ## Draw the settings popup. Should only be called if `ui.showSettings` is true
  drawRectangleLines(
      popupTopLeft(),
      popupSize(),
      borderColor)
  for wg in ui.settingsContent:
    ui.draw(wg)

