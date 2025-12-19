extends Node3D
class_name stage_manager

# === Nodes === #
@onready var off_stage_left: Node3D = $OffStageLeft
@onready var off_stage_right: Node3D = $OffStageRight
const TEMP = preload("res://Gameplay/Scenes/temp.tscn")
@onready var delete_timer: Timer = $Delete_Act_Timer

# === Position Vars === #
var actors_num:int = 1
var total_space:float = 0
var position_array:Array[Vector3]

enum enter_pos
{
  LEFT,
  RIGHT,
  TOP,
  BOTTOM
}

# === Actor Vars === #
var actor_array:Array ## probably of type Node3D or Skeleton or something
var removed_char

# === Export Vars === #
@export_category("Setting the Stage")
@export var all_actors:Array
@export var position_offset:Vector3
@export var time_to_enter:float = 0.25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  GameManager.stage_m = self
  
  total_space = ((off_stage_left.position.x + off_stage_right.position.x) - off_stage_left.position.x)

# Starts the process to adding a character to the scene
func add_actor(actor_name:StringName, enter_text:StringName = "LEFT"):
  var enter_from:enter_pos
  
  for actor in actor_array:
    if actor.char_name == actor_name:
      return
  
  match enter_text:
    "LEFT": enter_from = enter_pos.LEFT
    "RIGHT": enter_from = enter_pos.RIGHT
  
  var instance = TEMP.instantiate()
  instance.char_name = actor_name
  add_child(instance) ## This will cause bugs <-- Fix me pls

  match enter_from:
    enter_pos.LEFT: 
      actor_array.push_front(instance)
      instance.position = (Vector3(off_stage_left.position.x - 2, 0, 0) + position_offset)
    enter_pos.RIGHT: 
      actor_array.push_back(instance)
      instance.position = (Vector3(off_stage_right.position.x + 2, 0, 0) + position_offset)  
    enter_pos.TOP: pass
    enter_pos.BOTTOM: pass
  
  actors_num += 1
  set_positions(enter_from)

# Sets the Vector3 Positions where characters will be placed
func set_positions(enter_from:enter_pos = enter_pos.LEFT):
  if actors_num <= 0: return
  # Set vars
  var pos:Vector3 = position_offset
  var pos_dist:float
  pos_dist = total_space / actors_num
  
  position_array.clear()
  # Iterate to create position_array
  for x in actors_num - 1:
    pos.x += pos_dist
    position_array.append(pos)
    var tween = get_tree().create_tween()
    tween.tween_property(actor_array[x], "position", position_array[x], time_to_enter)
    
# Starts the process for removing a character from the scene
func remove_actor(to_remove:StringName, exit_dir:StringName = "RIGHT"): ## JUST REDO THIS
  var exit_to:enter_pos
  var can_remove:bool = false
  var temp_array:Array = actor_array
  
  match exit_dir:
    "LEFT": exit_to = enter_pos.LEFT
    "RIGHT": exit_to = enter_pos.RIGHT
  
  for a in actor_array.size() -1:
    if actor_array[a].char_name == to_remove: 
      can_remove = true
      temp_array.remove_at(a - 1)
      removed_char = actor_array[a]
  
  if can_remove:
    var tween = get_tree().create_tween()
    
    match exit_to:
      enter_pos.LEFT:
        tween.tween_property(removed_char, "position", off_stage_left.position + Vector3(off_stage_left.position.x - 2,1,0), 0.25)
      enter_pos.RIGHT:
        tween.tween_property(removed_char, "position", off_stage_right.position + Vector3(off_stage_right.position.x + 2,1,0), 0.25)
        
    actor_array.erase(removed_char)
    removed_char.delete_timer.start()
    actors_num -= 1
    set_positions()
    return

# this will place all characters based on the required setup from load game
func load_scene():
  pass
