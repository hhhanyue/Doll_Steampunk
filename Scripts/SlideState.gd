extends StateBase

class_name SlideState

func enter() -> void:
	super.enter()
	player.is_slide=true
	anim.play("Player_Slide")
	
func exit()->void:
	super.exit()
	player.is_slide=false
	
##渲染帧触发
func pocess_update(delta: float)->void:
	super.pocess_update(delta)
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	super.physice_pocess_update(delta)
	player.velocity.y=player.slide_gravity
	player.move(delta)
	if player.direction.y>0:
		player.is_slide=false
		state_machine.change_state("SlideJump")
	
	if not player.is_wall_detected():
		state_machine.change_state("IdleState")
	elif player.is_in_ground():
		state_machine.change_state("IdleState")
	
