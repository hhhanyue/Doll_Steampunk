extends FishManStateBase

class_name FishManAttack1

var is_attacking:bool

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
		if fishman.global_position.distance_to(player.global_position)<5:
			fishman.velocity=Vector2.ZERO
			is_attacking=true
			anim.play("FishMan_Attack_1")
		else:
			fishman.Move(delta,player_in_lft_or_rig(),fishman.speed)
			fishman.move_and_slide()
