extends Node
class_name character

@export var char_name:StringName
@onready var delete_timer: Timer = $DeleteTimer

func _on_delete_timer_timeout() -> void:
  self.queue_free()
