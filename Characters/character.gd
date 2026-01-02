extends Node
class_name character

@export var char_name:StringName
@export var anim_player:AnimationPlayer

@onready var delete_timer: Timer = $DeleteTimer
@onready var model: Node3D = $TEST_MODEL_01

func _ready() -> void:
  anim_player = model.get_child(1) # Hard coded and magic number pilled - BAD

func play_anim(to_play:StringName):
  anim_player.play(to_play)

func _on_delete_timer_timeout() -> void:
  self.queue_free()
