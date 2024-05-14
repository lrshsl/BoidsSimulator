from settings import toggleSettingsPopup, settingsContent
from types import Ui, Widget
import ../constants

import nimraylib_now

# Getter function to retrieve the value of a slider
proc get*[Slider](ui: Ui, s: Slider): float =
  ## Get the value of a slider. Takes a Slider enum and the main ui as arguments.
  ui.widgets[s.int].value

# Can only be runtime-evaluated because it needs to know the screen/window size
proc settingsButton(): Widget =
  Widget(
    kind: Button,
    pos: settingsButtonPos(),
    size: settingsButtonSize(),
    bgColor: bgColor,
    borderColor: borderColor,
    textColor: textColor,
    buttonText: "Settings",
    onClick: toggleSettingsPopup)

# Helper function to create a slider with the metadata from the consts above
proc createDefaultSliderAt(
    pos: Vector2,
    width: float,
    name: string,
    defaultValue, minValue, maxValue: float): Widget =
  Widget(kind: Slider,
         pos: pos,
         size: Vector2(x: width, y: widgetHeight()),
         bgColor: bgColor,
         fillColor: fillColor,
         borderColor: borderColor,
         textColor: textColor,
         name: name,
         showName: showSliderNameDefault,
         showValue: showSliderValueDefault,
         value: defaultValue,
         high: maxValue,
         low: minValue)

# Create all the widgets with the inforamtion from `sliderInfo` above
proc createWidgets(): seq[Widget] =

  # Top row
  for i, (name, defaultVal, minVal, maxVal) in top_row:
    let
      widgetWidthTop = (screenWidth.float - 2 * margin) / float(top_row.len + 1)
      x = margin + float(i.int mod top_row.len) * widgetWidthTop
      y = margin
    result.add(createDefaultSliderAt(Vector2(x: x, y: y), widgetWidthTop, name, defaultVal, minVal, maxVal))

  # Bottom row
  for i1, (name, defaultVal, minVal, maxVal) in bottom_row:
    let
      i = i1.ord - BottomRow.low.ord
      widgetWidthBottom = (screenWidth.float - 2 * margin) / bottom_row.len.float
      x = margin + float(i.int mod bottom_row.len) * widgetWidthBottom
      y = screenHeight.float - widgetHeight() - margin
    result.add(createDefaultSliderAt(Vector2(x: x, y: y), widgetWidthBottom, name, defaultVal, minVal, maxVal))

  # Settings button
  result.add(settingsButton())


# Export a simple, easy to use function
proc setupMainUi*(): Ui =
  ## Create the main ui. Is called once before the game loop. It initializes all the widgets and settings.
  Ui(widgets: createWidgets(), settingsContent: settingsContent())
  

