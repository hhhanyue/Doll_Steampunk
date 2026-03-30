extends FishManStateBase

class_name FishManAttack2

var is_attacking:bool
var statetime:float=0.5
var statetimer:float

func enter() -> void:
	is_attacking=false
	
func exit()->void:
	pass
	
##渲染帧触发
func pocess_update(delta: float)->void:
	pass
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	if not is_attacking:
		##如果不在攻击接近玩家
		if statetimer<0:
			state_machine.change_state("FishManPatrolState")
		##变量以后放到fishman里
		if fishman.global_position.distance_to(player.global_position)<12:
			fishman.velocity=Vector2.ZERO
			is_attacking=true
			anim.play("FishMan_Attack_2")
		else:
			if fishman.is_in_ground(fishman.ground_check_front):
				fishman.Move(delta,player_in_lft_or_rig(),fishman.speed)
				fishman.move_and_slide()
			
	if fishman.hitplayer:
		##进入投技状态
		fishman.state_machine.change_state("FishManCatchPlayer")
		fishman.hitplayer=false
		pass
