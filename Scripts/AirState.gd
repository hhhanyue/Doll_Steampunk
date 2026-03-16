extends StateBase

class_name AirState

func enter() -> void:
	super.enter()
	
func exit()->void:
	super.exit()
	
##渲染帧触发
func pocess_update(delta: float)->void:
	super.pocess_update(delta)
	
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	super.physice_pocess_update(delta)
	player.move(delta)
	player.fall(delta)
	is_rise_or_fall()
	if player.is_in_ground():
		state_machine.change_state("IdleState")
		
	##同向
	if (player.is_wall_detected() and player.is_movedir_sim_facedir()):
		state_machine.change_state("SlideState")
	
	should_flip()
