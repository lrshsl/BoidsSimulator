from settings import drawSettings, settingsWidgets, clicklessUi
from draw_widget import draw
from types import Ui, Widget, WidgetKind
import ../util
import ../constants

import nimraylib_now

import math

proc update*(ui: Ui, wg: var Widget) =
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
    if (clicklessUi or isMouseButtonDown(MouseButton.Left)) and
        x > wg.pos.x and x < wg.pos.x + wg.size.x and
        y > wg.pos.y and y < wg.pos.y + wg.size.y:
      wg.value = (x - wg.pos.x) / wg.size.x * (wg.high - wg.low) + wg.low

proc `draw`*(ui: Ui) =
  for wg in ui.widgets:
    ui.draw(wg)
  if ui.showSettings:
    ui.drawSettings()

proc `update`*(ui: var Ui) =
  for wg in ui.widgets.mitems:
    ui.update(wg)
  if ui.showSettings:
    for wg in settingsWidgets.mitems:
      ui.update(wg)

