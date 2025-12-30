extends Node

const MAIN_MENU_SCENE:StringName = "res://Gameplay/Scenes/main_menu_scene.tscn"
const STAGE_SCENE:StringName = "res://Gameplay/Scenes/stage.tscn"
const SCENE_VIEWER_SCENE:StringName = "res://Gameplay/Scenes/scene_viewer.tscn"

@export var minimum_load_time:float = 1

var current_scene:Node3D

var is_loading:bool = false
var path:StringName
  
func load_scene(scene:StringName):
  # get the scene's path to load
  match scene:
    "MAIN_MENU": path = MAIN_MENU_SCENE
    "STAGE": path = STAGE_SCENE
    "VIEWER": path = SCENE_VIEWER_SCENE
  
  # Call the loading Screen to fade in
  #UiManager.loadingScene.fade_in()
  # Remove the Current Scene
  remove_child(current_scene)
  # Async Load the next Scene
  ResourceLoader.load_threaded_request(path)
  is_loading = true

# Using _process to check if we are loading something and if we are finished loading something
func _process(_delta: float) -> void:
  if is_loading:
    if ResourceLoader.load_threaded_get_status(path) == ResourceLoader.THREAD_LOAD_LOADED:
      current_scene = ResourceLoader.load_threaded_get(path).instantiate()
      await get_tree().create_timer(minimum_load_time).timeout
      add_child(current_scene)
      #UiManager.loadingScene.fade_out()
      is_loading = false
      # emit correct signal
      match path:
        MAIN_MENU_SCENE: SignalBus.emit_signal("main_menu_loaded")
        STAGE_SCENE: SignalBus.emit_signal("gameplay_loaded", "TEST_DIALOGUE")
        SCENE_VIEWER_SCENE: SignalBus.emit_signal("scene_view_loaded")
    
