extends GroundState

class_name MoveState



func enter()->void:
	super.enter()
	anim.play("Player_Move")
	
func pocess_update(delta: float) -> void:
	super.pocess_update(delta)

func physice_pocess_update(delta: float)->void:
	super.physice_pocess_update(delta)
	if player.direction==Vector2.ZERO:
		state_machine.change_state("IdleState")
	should_flip()
	
	
	
func exit()->void:
	super.exit()
	
