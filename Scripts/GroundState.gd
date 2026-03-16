extends StateBase

class_name GroundState

func enter()->void:
	super.enter()
	
func pocess_update(delta: float) -> void:
	super.pocess_update(delta)
func physice_pocess_update(delta: float)->void:
	super.physice_pocess_update(delta)
	
	player.move(delta)
	player.fall(delta)
	if not player.is_in_ground():
		state_machine.change_state("AirState")
	if player.direction.y>0:
		player.velocity.y=player.jump_force
	
func exit()->void:
	super.exit()
