extends Node2D

##基础状态
class_name PlayerStateBase
##玩家节点
var player:Player
var state_machine:PlayerStateMachine
var anim:AnimationPlayer
var body: Body
var collision:CollisionShape2D


func init(player:Player,anim:AnimationPlayer,body:Body,collision:CollisionShape2D)->void:
	self.player=player
	self.anim=anim
	self.body=body
	self.collision=collision

func enter() -> void:
	pass
	
func exit()->void:
	pass
	
##渲染帧触发
func pocess_update(delta: float)->void:
	pass
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	if not player.is_attack and Input.is_action_just_pressed("dash") and player.candash:
		state_machine.change_state("DashState")
	
	player.move_and_slide()
	
##判断翻转
func should_flip()->void:
	if (player.facing_dir>0 and player.velocity.x<0) or (player.facing_dir<0 and player.velocity.x>0):
		player.facing_dir=player.facing_dir*-1
		collision.scale.x=-collision.scale.x
		body.flip()
		
##在空中是上升还是下降
func is_rise_or_fall()->void:
	if player.velocity.y<0:
		anim.play("Player_Jump")
	else:
		anim.play("Player_Fall")
