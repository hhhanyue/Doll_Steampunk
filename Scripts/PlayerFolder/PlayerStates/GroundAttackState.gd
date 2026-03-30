extends PlayerStateBase

class_name GroundAttackState

func enter() -> void:
	super.enter()
	anim.play("Player_Ground_Attack")
	player.is_attack=true
	player.attack_enemy_list=[]
	
func exit()->void:
	player.is_attack=false
	super.exit()
	
##渲染帧触发
func pocess_update(delta: float)->void:
	super.pocess_update(delta)
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	player.velocity=Vector2.ZERO
	super.physice_pocess_update(delta)
