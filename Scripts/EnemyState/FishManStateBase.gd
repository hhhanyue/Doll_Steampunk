extends Node2D

class_name FishManStateBase

var fishman:FishMan
var state_machine:EnemyStateMachine
var anim:AnimationPlayer
var body: Body
var collision:CollisionShape2D
var player:Player

func init(enemy:FishMan,anim:AnimationPlayer,body:Body,collision:CollisionShape2D)->void:
	self.fishman=enemy
	self.anim=anim
	self.body=body
	self.collision=collision
	player=PlayerManger.instance.player

func enter() -> void:
	pass
	
func exit()->void:
	pass
	
##渲染帧触发
func pocess_update(delta: float)->void:
	pass
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	fishman.move_and_slide()
	
func facing_forward()->void:
	if fishman.velocity.x>0:
		body.scale=Vector2(1,1)
	if fishman.velocity.x<0:
		body.scale=Vector2(-1,1)
