extends CharacterBody2D
##玩家
class_name Player



@onready var player: Player = $"."
@export var state_machine:PlayerStateMachine
@onready var anim:AnimationPlayer=$"AnimationPlayer"
@onready var ground_check: RayCast2D = $Body/GroundCheck
@onready var wall_check: ShapeCast2D = $Body/WallCheck
@onready var ledge_check: ShapeCast2D = $Body/LedgeCheck

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
	state_machine.statemachine_ready()

func _process(delta: float) -> void:
	state_machine.statemachine_process(delta)

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
	state_machine.statemachine_physics_process(delta)
	
	
##是否在地面
func is_in_ground()->bool:
	var ground_collid_object=ground_check.get_collider()
	if ground_collid_object is TileMapLayer:
		return true
	return false
	
##朝向是否是墙
func is_wall_detected()->bool:
	wall_check.force_shapecast_update()
	if wall_check.is_colliding():
		var count = wall_check.get_collision_count()
		for i in range(count):
			
			var collider = wall_check.get_collider(i)
			if collider is TileMapLayer:
				return true
	return false
	
##高处是否检测到障碍
func is_ledge_detected()->bool:
	ledge_check.force_shapecast_update()
	if ledge_check.is_colliding():
		var count = ledge_check.get_collision_count()
		for i in range(count):
			var collider = ledge_check.get_collider(i)
			if collider is TileMapLayer:
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
		return true
	return false
	
func climb()->void:
	
	velocity = Vector2.ZERO
	##播放攀爬动画
	anim.play("Player_Climb",-1,0.5)
	##定义并播放tween补间动画
	var tween = create_tween().set_parallel(false)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	##向上的高度
	tween.tween_property(self, "global_position:y", global_position.y - 3, 0.2)
	##向平台的距离
	tween.parallel().tween_property(self, "global_position:x", global_position.x + (facing_dir * 4), 0.3).set_delay(0.1)
	##补间动画束后调用
	tween.finished.connect(_end_climb)
	
func _end_climb():
	state_machine.change_state("IdleState")
	
func _finish_attack():
	state_machine.change_state("IdleState")
	
	
	
