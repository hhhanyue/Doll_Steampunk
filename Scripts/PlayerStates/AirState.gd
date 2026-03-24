extends PlayerStateBase

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
	player.move(delta)
	player.fall(delta)
	#到达地面 
	if player.is_in_ground():
		state_machine.change_state("IdleState")
		return
	
	if not player.is_ledge_detected() and player.is_wall_detected() and player.is_movedir_sim_facedir():
		state_machine.change_state("HangState")
		return
	##同向且检测到墙
	if (player.is_wall_detected() and player.is_movedir_sim_facedir()):
		state_machine.change_state("SlideState")
		return
	
	should_flip()
	is_rise_or_fall()
	super.physice_pocess_update(delta)
