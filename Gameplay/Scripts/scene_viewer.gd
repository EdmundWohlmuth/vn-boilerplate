extends Node3D

# === Rotation Vars === #
var rot_degs:Array[int] = [8, 15, 24, 36, 45, 60, 90]
var rot_index:int = 1
var deg_to_rotate:int = 15

# === Characters === #
@export var char_01:MeshInstance3D

func _ready() -> void:
  UiManager.scene_viewer_ui.scene_viewer = self

# set the rotation index to change the degrees that the character will rotate by
func change_rot_index(increase_index:bool):
  if increase_index && (rot_index + 1) >= rot_degs.size():
    rot_index = 0
  elif !increase_index && (rot_index - 1) <= 0:
    rot_index = rot_degs.size()
  elif increase_index && (rot_index + 1) < rot_degs.size():
    rot_index += 1
  elif increase_index && (rot_index + 1) > 0:
    rot_index -= 1
  
  deg_to_rotate = rot_degs[rot_index]

# Roatate the character
func roatate_character(clockwise:bool):
  if clockwise: char_01.rotation_degrees += Vector3(0, deg_to_rotate, 0)
  else: char_01.rotation_degrees -= Vector3(0, deg_to_rotate, 0)
