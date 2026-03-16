extends Node2D

##角色状态机
class_name StateMachine

##默认状态
@export var current_state:StateBase

func _ready()->void:
	for child in get_children():
		if child is StateBase:
			child.state_machine=self
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
