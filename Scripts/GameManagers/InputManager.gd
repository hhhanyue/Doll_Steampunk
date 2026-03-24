extends Node2D

class_name InputManager

var is_attack_input:bool=false
var attack_input_timer:float=0.2
var attack_input_time:float=0
static var instance:InputManager

##Awake
func _enter_tree():
	if instance == null:
		instance = self
	else:
		queue_free() # 如果已经存在实例，销毁当前重复的

func _physics_process(delta: float) -> void:
	attack_input_time-=delta
	if attack_input_time<0:
		is_attack_input=false
	if Input.is_action_pressed("Attack"):
		attack_input_time=attack_input_timer
		is_attack_input=true
