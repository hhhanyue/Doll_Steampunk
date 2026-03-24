extends CharacterBody2D

class_name Enemy

@onready var enemy:Enemy = $"."
@export var state_machine:EnemyStateMachine
@onready var anim:AnimationPlayer=$"AnimationPlayer"

@export var speed:float =800
var gravity:float=100

var facing_direction:int=1

func _ready() -> void:
	pass


func fall(delta:float)->void:
	if self.velocity.y<gravity:
		self.velocity.y+=gravity*delta
		
func Move(delat:float)->void:
	self.velocity.x=facing_direction*delat*speed
	

	
