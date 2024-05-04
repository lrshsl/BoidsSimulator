from settings import toggleSettings
from types import Ui, Widget
import ../constants

import nimraylib_now

# Getter function to retrieve the value of a slider
proc get*[Slider](ui: Ui, s: Slider): float =
  ui.widgets[s.int].value

# Can only be runtime-evaluated because it needs to know the screen/window size
let
  settings_button = Widget(
      kind: Button,
      pos: settingsButtonPos,
      size: settingsButtonSize,
      bgColor: bgColor,
      borderColor: borderColor,
      textColor: textColor,
      buttonText: "Settings",
      onClick: toggleSettings)

# Helper function to create a slider with the metadata from the consts above
proc createDefaultSliderAt(
    pos: Vector2,
    name: string,
    defaultValue, minValue, maxValue: float): Widget =
  Widget(kind: Slider,
         pos: pos,
         size: Vector2(x: widgetWidth, y: widgetHeight),
         bgColor: bgColor,
         fillColor: fillColor,
         borderColor: borderColor,
         textColor: textColor,
         name: name,
         showName: showSliderName,
         showValue: showSliderValue,
         value: defaultValue,
         high: maxValue,
         low: minValue)

# Create all the widgets with the inforamtion from `sliderInfo` above
proc createWidgets(): seq[Widget] =
  # Top row
  for i, (name, defaultVal, minVal, maxVal) in top_row:
    let
      x = margin + float(i.int mod numWidgetsPerRow) * widgetWidth
      y = margin + float(int(i.int / numWidgetsPerRow)) * (widgetHeight + margin)
    result.add(createDefaultSliderAt(Vector2(x: x, y: y), name, defaultVal, minVal, maxVal))

  # Bottom row
  for i1, (name, defaultVal, minVal, maxVal) in bottom_row:
    let
      i = i1.ord - BottomRow.low.ord
      widgetWidthBottom = (ScreenWidth.float - 2 * margin) / bottom_row.len.float
      x = margin + float(i.int mod bottom_row.len) * widgetWidthBottom
      y = ScreenHeight.float - widgetHeight - margin
    result.add(createDefaultSliderAt(Vector2(x: x, y: y), name, defaultVal, minVal, maxVal))

  # Settings button
  result.add(settings_button)


# Export a simple, easy to use function
proc setupMainUi*(): Ui =
  Ui(widgets: createWidgets())
  

