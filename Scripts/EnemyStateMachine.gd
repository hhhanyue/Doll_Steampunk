extends Node2D

class_name EnemyStateMachine

@export var current_state:FishManStateBase

var body:Body
var anim:AnimationPlayer
var enemy:Enemy
var collision:CollisionShape2D

func _ready()->void:
	get_necessary_node()
	await get_parent().ready
	current_state.enter()
	
func _process(delta: float) -> void:
	current_state.pocess_update(delta)

func _physics_process(delta: float) -> void:
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
	enemy=get_parent()
	for child in enemy.get_children():
		if child is Body:
			body=child
		if child is AnimationPlayer:
			anim=child
		if child is CollisionShape2D:
			collision=child
		enemy=child.get_parent()
	for child in get_children():
		if child is FishManStateBase:
			child.state_machine=self
			child.init(enemy,anim,body,collision)
