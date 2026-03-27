extends FishManStateBase

class_name FishManAttack1

var is_attacking:bool
var statetime:float=0.5
var statetimer:float

func enter() -> void:
	is_attacking=false
	statetimer=statetime
	
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
		if fishman.global_position.distance_to(player.global_position)<5:
			fishman.velocity=Vector2.ZERO
			is_attacking=true
			anim.play("FishMan_Attack_1")
		else:
			if fishman.is_in_ground(fishman.ground_check_front):
				fishman.Move(delta,player_in_lft_or_rig(),fishman.speed)
				fishman.move_and_slide()
	if fishman.hitplayer:
		player.damge(fishman.fishman_damage)
		fishman.hitplayer=false
	statetimer-=delta
