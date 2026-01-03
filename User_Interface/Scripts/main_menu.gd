extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  GameManager.main_menu = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  pass
  

func _on_button_pressed() -> void:
  Scene_Manager.load_scene("STAGE")
  #UiManager.set_dialogue()
  

func _on_button_2_pressed() -> void:
  Scene_Manager.load_scene("VIEWER")
  #UiManager.set_scene_viewer()
