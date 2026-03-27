extends PlayerStateBase

class_name GroundState

func enter()->void:
	player.is_doulejumped=false
	super.enter()
	
func pocess_update(delta: float) -> void:
	super.pocess_update(delta)
func physice_pocess_update(delta: float)->void:
	if InputManager.instance.is_attack_input:
		state_machine.change_state("GroundAttackState")
		InputManager.instance.is_attack_input=false
		return
	if not player.is_in_ground():
		state_machine.change_state("AirState")
		return
	if player.direction.y>0:
		player.velocity.y=player.jump_force
	super.physice_pocess_update(delta)
	
func exit()->void:
	super.exit()
