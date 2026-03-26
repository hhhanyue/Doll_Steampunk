extends CharacterBody2D

class_name Enemy

@onready var enemy:Enemy = $"."
@export var state_machine:EnemyStateMachine
@onready var anim:AnimationPlayer=$"AnimationPlayer"
@onready var ground_check_front:RayCast2D=$"Body/GroundCheckFront"
@onready var ground_check_back:RayCast2D=$"Body/GroundCheckBack"

@export var speed:float =800
var gravity:float=100

var facing_direction:int=1

func _ready() -> void:
	pass


func fall(delta:float)->void:
	if self.velocity.y<gravity:
		self.velocity.y+=gravity*delta
		
func Move(delat:float,direction:int,speed:float)->void:
	self.velocity.x=direction*delat*speed
	
func is_in_ground(groundcheck:RayCast2D)->bool:
	var ground_collid_object=groundcheck.get_collider()
	if ground_collid_object is TileMapLayer:
		return true
	return false
