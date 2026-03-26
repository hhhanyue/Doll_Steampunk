extends PlayerStateBase

class_name SlideJump

var state_timer:float
func enter() -> void:
	super.enter()
	anim.play("Player_Jump")
	state_timer=0.1
	player.velocity.x=player.facing_dir*-15
	player.velocity.y=player.jump_force
	
func physice_pocess_update(delta: float)->void:
	state_timer-=delta
	is_rise_or_fall()
	should_flip()
	player.fall(delta)
	if state_timer<0:
		state_machine.change_state("IdleState")
	super.physice_pocess_update(delta)
