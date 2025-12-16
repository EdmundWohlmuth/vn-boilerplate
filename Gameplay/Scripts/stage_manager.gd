extends Node3D
class_name stage_manager

# === Nodes === #
@onready var off_stage_left: Node3D = $OffStageLeft
@onready var off_stage_right: Node3D = $OffStageRight
const TEMP = preload("res://Gameplay/Scenes/temp.tscn")

# === Position Vars === #
var actors_num:int = 10
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

# === Export Vars === #
@export_category("Setting the Stage")
@export var all_actors:Array
@export var position_offset:Vector3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  total_space = ((off_stage_left.position.x + off_stage_right.position.x) - off_stage_left.position.x)
  var temp_name:StringName = "Test"
  add_actor(temp_name)

# Starts the process to adding a character to the scene
func add_actor(actor_name:StringName): 
  for actor in all_actors:
    if actor.char_name == actor_name:
      break
  
  actors_num += 1
  set_positions(enter_pos.LEFT)

# Sets the Vector3 Positions where characters will be placed
func set_positions(enter_from:enter_pos):
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
    var instance = TEMP.instantiate()
    add_child(instance)
    instance.position = pos

# this will place all characters based on the required setup from load game
func load_scene():
  pass
