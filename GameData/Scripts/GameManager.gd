extends Node

# === Player Prefs === #
@export var dialogue_display_speed:float = 0.05

# === Game Nodes === #
var stage_m:stage_manager
var dialogue_m

# === Current Data === #
var current_chapter:int = 0
var current_index:int = 0
var current_dialogue:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  pass
