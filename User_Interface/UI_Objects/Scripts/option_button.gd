extends Button
class_name Option_Button

var dialogue:String
signal return_dialogue 

func _on_pressed() -> void:
  emit_signal("return_dialogue", dialogue)
