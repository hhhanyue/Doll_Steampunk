extends CharacterBody2D
##玩家
class_name Player



@onready var player: Player = $"."
@export var state_machine:StateMachine
@onready var ground_check: RayCast2D = $Body/GroundCheck
@onready var wall_check: RayCast2D = $Body/WallCheck

##move
@export var speed:float =800
@export var jump_force:float =-50
var gravity:float=100
@export var slide_gravity:float=10
var is_slide:bool=false

##输入方向
var direction:Vector2
##1为右
var facing_dir:int=1

##idle的enter
func _ready() -> void:
	ground_check.add_exception(player)

func _process(delta: float) -> void:
	state_machine.current_state.pocess_update(delta)
	pass

func _physics_process(delta: float) -> void:
	direction=Vector2.ZERO
	is_in_ground()
	##输入
	if Input.is_action_pressed("move_left"):
		direction.x-=1
	if Input.is_action_pressed("move_right"):
		direction.x+=1
	if Input.is_action_just_pressed("jump"):
		direction.y+=1
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	player.move_and_slide()
	
##是否在地面
func is_in_ground()->bool:
	var ground_collid_object=ground_check.get_collider()
	if ground_collid_object is TileMapLayer:
		return true
	return false
	
##朝向是否是墙
func is_wall_detected()->bool:
	var wall_collid_object=wall_check.get_collider()
	
	if wall_collid_object is TileMapLayer:
		print("碰墙")
		return true
	return false
	
#下落逻辑
func fall(delta:float)->void:
	if player.velocity.y<gravity:
		player.velocity.y+=gravity*delta

func move(delta:float)->void:
	player.velocity.x =direction.x * speed*delta

##移动方向与面朝方向是否一致
func is_movedir_sim_facedir()->bool:
	if player.facing_dir*player.direction.x>0:
		print("true")
		return true
	return false
	
