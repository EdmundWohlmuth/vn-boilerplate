extends Control

# == NODES == #
@export_category("Required Nodes")
@export var dialogue_panel:Panel
@export var dialogue_text_label:RichTextLabel
@export var dialogue_name_label:RichTextLabel
@export var desision_container:VBoxContainer
@export_category("Dialogue Array")
@export var Dialogues:Array[JSON]

# == DATA == #
var dialogue_data = {}

# == SIGNALS == #
#signal add_char
#signal remove_char

# == BOOLS == #
var is_selected:bool = false
var is_text_finished:bool = false

# == DIALOGUE VARIABLES == #
var dialogue:Dictionary
var yes_key:Dictionary
var no_key:Dictionary
var index:int = 0
var is_read:bool = false

# _Ready runs on runtime
func _ready():
  GameManager.dialogue_m = self
  
  dialogue_data = Dialogues[0].data
  dialogue_text_label.text = ""
  dialogue_name_label.text = ""
  
  # Connect the pressed signal to here
  for i in desision_container.get_children().size():
    var but:Button = desision_container.get_child(i)
    but.connect("return_dialogue", start_dialogue)

# Starts a dialogue chain from it's beginging  
func start_dialogue(dialogue_to_start:String):
  index = 0
  is_text_finished = false
  
  hide_options()

  dialogue = dialogue_data[dialogue_to_start]
  slow_display_text(dialogue[str(index)]["Text"])

 
func hide_options():
  if desision_container != null:
    for i in desision_container.get_children():
      i.visible = false
   
# classic check if hover check
func _on_panel_mouse_entered():
  is_selected = true
func _on_panel_mouse_exited():
  is_selected = false
  
# slowly displays the text of a stirng character by character and checks for BBCode elements
func slow_display_text(text:String):
  var to_display
  var wait_until
  var waiting:bool = false
  dialogue_text_label.text = ""
  dialogue_name_label.text = dialogue[str(index)]["Name"]
  
  # Check if a character needs to be added / removed
  character_check()
  
  # Iterate through the String and add the next letter to the Textbox
  for i in text.length():
    # checking for BBCode element ([)
    if (text[i] == '['): 
      to_display = complete_text_effect(i, text)
      wait_until = i + complete_text_effect(i, text).length() -1
      waiting = true
    elif waiting == false: 
      to_display = text[i]

    # check if i has caught up to where the BBCode ends
    if i == wait_until && waiting == true: waiting = false
    if waiting == false: 
      # add text to RichTextLabel node
      dialogue_text_label.text += to_display
      await get_tree().create_timer(0.05).timeout # USE GAMEMANAGER 
    
    # if player skiped text exit early
    if is_text_finished: return
    
  is_text_finished = true
  index += 1

# Checks to see if a character is added and or removed
func character_check():
  if dialogue[str(index)].has("Add_Char"):
    GameManager.stage_m.add_actor(dialogue[str(index)]["Char_to_Add"], dialogue[str(index)]["Enter_From"], dialogue[str(index)]["Add_Char"])
  if dialogue[str(index)].has("Remove_Char"):
    GameManager.stage_m.remove_actor(dialogue[str(index)]["Remove_Char"], dialogue[str(index)]["Exit_To"])
  
# parses the string to display enclosed [] at the same time
func complete_text_effect(string_index, text:String) -> String:
  var effect:String = ""
  for x in range(string_index, text.length()):
    effect += text[x]
    if text[x] == ']': break

  return effect
  
# displays the whole text usualy run if the player clicks on textbox while it's being displayed
func full_display_text(text:String):
  dialogue_text_label.text = text
  is_text_finished = true
  index += 1

func _input(event):
  if event.is_action_pressed("Click") && !is_read:
    is_read = true
    start_dialogue("TEST_DIALOGUE")
  
  # Skip slow print out of dialogue on click 
  if (event.is_action_pressed("Click") && is_selected && !is_text_finished):
    full_display_text(dialogue[str(index)]["Text"])
  # Check for the next line of dialogue  
  elif (event.is_action_pressed("Click") && is_selected && is_text_finished): 
  # On end of Dialogue - These dialogues should have the "Next Dialogue" and "Is_End" variables
    if index > (dialogue.size() -1):
      get_next_dialogue()
      return
    is_text_finished = false
    slow_display_text(dialogue[str(index)]["Text"])    

# Search the JSON for what text to run next; either by opening options, running the "goto" string or
# changing the JSON data that is being read from - Good for organising 'Dialogue.JSON's into 'chapters'
func get_next_dialogue():
  var dialogue_string:String = ""
  if index == 0: index = 1
  
  # Do Options
  if dialogue[str(index - 1)].has("Options"):
    if dialogue[str(index - 1)]["Options"] == true:
      set_options(dialogue[str(index - 1)]["Options_Num"])
  # Goto the Specified Dialogue   
  elif dialogue[str(index - 1)].has("Goto"): 
    if dialogue[str(index - 1)]["Goto"] == true:
      start_dialogue(dialogue[str(index - 1)]["Goto_Text"])
  # Change the JSON data  
  elif dialogue[str(index - 1)].has("End_Chapter"):
    if dialogue[str(index - 1)]["End_Chapter"] == true:
      goto_next_chapter()

# Enables Options buttons based on the JSON value provided
func set_options(num_to_enable:int): 
  for o in num_to_enable:
    var child:Option_Button = desision_container.get_child(o)
    child.dialogue = dialogue[str(index - 1)]["Go_To_Text_" + str(o)]
    child.text = dialogue[str(index - 1)]["Option_" + str(o) + "_Name"]
    child.visible = true

# Changes the JSON to read from
func goto_next_chapter():
  var dialogue_to_start:String = dialogue[str(index - 1)]["Goto_Text"]
  
  dialogue_data = Dialogues[dialogue[str(index - 1)]["Chapter_Index"]].data
  start_dialogue(dialogue_to_start)

# Enables a new scene to display other stuff
func goto_special():
  pass
