extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $ColorRect/Label

@export var fade_time:float = 1

signal finished_fade_in
signal finished_fade_out

# Fades the Loading Screen in and awaits the tween to finish
func fade_in():
  var tween = create_tween().tween_property(color_rect, "color", Color.BLACK, fade_time)
  var tween2 = create_tween().tween_property(label, "color", Color.WHITE, fade_time)
  
  await tween.finished
  emit_signal("finished_fade_in")
 
# Fades the Loading Screen out and awaits the tween to finish 
func fade_out():
  var tween = create_tween().tween_property(color_rect, "color", Color.TRANSPARENT, fade_time)
  var tween2 = create_tween().tween_property(label, "color", Color.TRANSPARENT, fade_time)
  
  await tween.finished
  emit_signal("finished_fade_out")
