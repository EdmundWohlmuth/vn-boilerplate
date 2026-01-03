extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $ColorRect/Label

@export var fade_time:float = 1

func _ready() -> void:
  SignalBus.connect("load_fade_in", fade_in)
  SignalBus.connect("load_fade_out", fade_out)

# Fades the Loading Screen in and awaits the tween to finish
func fade_in():
  var _tween = create_tween().tween_property(color_rect, "color", Color.BLACK, fade_time)
  var _tween2 = create_tween().tween_property(label, "theme_override_colors/font_color", Color.WHITE, fade_time)
  UiManager.hide_ui()

# Fades the Loading Screen out and awaits the tween to finish 
func fade_out():
  var _tween = create_tween().tween_property(color_rect, "color", Color.TRANSPARENT, fade_time)
  var _tween2 = create_tween().tween_property(label, "theme_override_colors/font_color", Color.TRANSPARENT, fade_time)
