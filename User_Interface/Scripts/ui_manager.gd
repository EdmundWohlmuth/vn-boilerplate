extends Control

@onready var scene_viewer_ui: Control = $Scene_Viewer_UI
@onready var dialogue_box: Control = $DialogueBox
@onready var loading_screen: Control = $loading_screen
@onready var main_menu: Control = $Main_Menu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  SignalBus.connect("gameplay_loaded", set_dialogue)
  SignalBus.connect("main_menu_loaded", set_main_menu)
  SignalBus.connect("scene_view_loaded", set_scene_viewer)
  set_main_menu()

func set_main_menu():
  main_menu.visible = true
  scene_viewer_ui.visible = false
  dialogue_box.visible = false

func set_dialogue(_dialogue:StringName):
  main_menu.visible = false
  scene_viewer_ui.visible = false
  dialogue_box.visible = true

func set_scene_viewer():
  main_menu.visible = false
  scene_viewer_ui.visible = true
  dialogue_box.visible = false

func hide_ui():
  main_menu.visible = false
  scene_viewer_ui.visible = false
  dialogue_box.visible = false
