extends PlayerStateBase

class_name GroundAttackState

func enter() -> void:
	super.enter()
	player.velocity=Vector2.ZERO
	anim.play("Player_Ground_Attack")
	
func exit()->void:
	super.exit()
	
##渲染帧触发
func pocess_update(delta: float)->void:
	super.pocess_update(delta)
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	player.velocity=Vector2.ZERO
	super.physice_pocess_update(delta)
