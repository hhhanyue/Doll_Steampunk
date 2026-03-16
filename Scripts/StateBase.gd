extends Node2D

##基础状态
class_name StateBase
##玩家节点
@export var player:Player
##状态机
@export var state_machine:StateMachine
@export var anim:AnimationPlayer
@export var body: Body


func enter() -> void:
	pass
	
func exit()->void:
	pass
	
##渲染帧触发
func pocess_update(delta: float)->void:
	pass
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	pass
	
func should_flip()->void:
	if (player.facing_dir>0 and player.direction.x<0) or (player.facing_dir<0 and player.direction.x>0):
		player.facing_dir=player.facing_dir*-1
		body.flip()
		
##在空中是上升还是下降
func is_rise_or_fall()->void:
	if player.velocity.y<0:
		anim.play("Player_Jump")
	else:
		anim.play("Player_Fall")
