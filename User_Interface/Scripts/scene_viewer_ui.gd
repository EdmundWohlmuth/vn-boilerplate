extends Control

# === Bool Vars === #
var is_on_panel:bool = false
# == Export Var === #
@export var scene_viewer:Node3D
# === Scene Objects === #
@onready var rot_l_button: Button = $HBoxContainer/Rot_L_Button
@onready var panel: Panel = $HBoxContainer/Panel
@onready var plabel: RichTextLabel = $HBoxContainer/Panel/RichTextLabel
@onready var rot_r_button: Button = $HBoxContainer/Rot_R_Button

func _on_rot_l_button_pressed() -> void:
  scene_viewer.roatate_character(false)

func _on_rot_r_button_pressed() -> void:
  scene_viewer.roatate_character(true)

func _on_panel_mouse_entered() -> void:
  is_on_panel = true

func _on_panel_mouse_exited() -> void:
  is_on_panel = false

func _input(event: InputEvent) -> void:
  if Input.is_action_just_pressed("Click") && is_on_panel:
    scene_viewer.change_rot_index(true)
    plabel.text = "[center]" + str(scene_viewer.rot_degs[scene_viewer.rot_index]) + " Degs" + "[/center]"
    
