from settings import drawSettingsPopup, clicklessUi, showSliderName, showSliderValue
from draw_widget import draw
from types import Ui, Widget, WidgetKind

import nimraylib_now

proc update*(ui: Ui, wg: var Widget) =
  ## Update the widget. Is called every frame. This is where click and hover events are registered and handled.

  let
    x = getMouseX().float
    y = getMouseY().float
  case wg.kind

  of Text, TextField:
    discard

  of Button:
    if wg.isBeingClicked:
      if isMouseButtonReleased(MouseButton.Left):
        wg.isBeingClicked = false
        if wg.onRelease != nil:
          wg.onRelease(ui)
    elif isMouseButtonDown(MouseButton.Left) and
        x > wg.pos.x and x < wg.pos.x + wg.size.x and
        y > wg.pos.y and y < wg.pos.y + wg.size.y:
      wg.isBeingClicked = true
      if wg.onClick != nil:
        wg.onClick(ui)

  of ToggleButton:
    if isMouseButtonReleased(MouseButton.Left) and
        x > wg.pos.x and x < wg.pos.x + wg.size.x and
        y > wg.pos.y and y < wg.pos.y + wg.size.y:
      if wg.isBeingClicked and wg.onRelease != nil:
        wg.onRelease(ui)
      elif not wg.isBeingClicked and wg.onClick != nil:
        wg.onClick(ui)
      wg.isBeingClicked = not wg.isBeingClicked

  of Slider:
    let isMouseOver = x > wg.pos.x and x < wg.pos.x + wg.size.x and
                      y > wg.pos.y and y < wg.pos.y + wg.size.y

    # Start dragging
    if (isMouseButtonDown(MouseButton.Left) and isMouseOver):
      wg.isBeingChanged = true

    # Update if dragging or clicklessUi is enabled
    if (clicklessUi and isMouseOver) or wg.isBeingChanged:
      wg.value = (x - wg.pos.x) / wg.size.x * (wg.high - wg.low) + wg.low
      wg.value = clamp(wg.value, wg.low, wg.high)

    # End dragging
    if isMouseButtonReleased(MouseButton.Left):
      wg.isBeingChanged = false

proc draw*(ui: Ui) =
  ## Draw all widgets. Is called every frame.
  for wg in ui.widgets:
    ui.draw(wg)
  if ui.showSettings:
    ui.drawSettingsPopup()

proc update*(ui: var Ui) =
  ## Update all widgets. Is called every frame.
  for wg in ui.widgets.mitems:
    ui.update(wg)
    if wg.kind == Slider:
      wg.showName = showSliderName
      wg.showValue = showSliderValue
  if ui.showSettings:
    for wg in ui.settingsContent.mitems:
      ui.update(wg)

