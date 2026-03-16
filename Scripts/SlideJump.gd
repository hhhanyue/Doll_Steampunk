extends StateBase

class_name SlideJump

var state_timer:float
func enter() -> void:
	super.enter()
	anim.play("Player_Jump")
	state_timer=0.2
	player.velocity.x=10*player.facing_dir
	player.velocity.y=player.jump_force
	
func physice_pocess_update(delta: float)->void:
	state_timer-=delta
	is_rise_or_fall()
	player.move(delta)
	player.fall(delta)
	if state_timer<0:
		state_machine.change_state("IdleState")
