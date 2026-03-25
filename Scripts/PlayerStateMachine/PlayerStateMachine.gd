extends Node2D

##角色状态机
class_name PlayerStateMachine

##默认状态
@export var current_state:PlayerStateBase

var body:Body
var anim:AnimationPlayer
var player:Player
var collision:CollisionShape2D

func statemachine_ready()->void:
	get_necessary_node()
	await get_parent().ready
	current_state.enter()
	
func statemachine_process(delta: float) -> void:
	current_state.pocess_update(delta)

func statemachine_physics_process(delta: float) -> void:
	current_state.physice_pocess_update(delta)
	
func change_state(target_state_name:String)->void:
	var target_state=get_node_or_null(target_state_name)
	if target_state ==null:
		printerr("未找到需要切换状态")
		return
	current_state.exit()
	current_state=target_state
	current_state.enter()
	
##获取player,animplayer,body节点
func get_necessary_node()->void:
	player=get_parent()
	for child in player.get_children():
		if child is Body:
			body=child
		if child is AnimationPlayer:
			anim=child
		if child is CollisionShape2D:
			collision=child
		player=child.get_parent()
	for child in get_children():
		if child is PlayerStateBase:
			child.state_machine=self
			child.init(player,anim,body,collision)
