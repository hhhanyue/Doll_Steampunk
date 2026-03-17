extends StateBase

class_name HangState

var is_quit_climb:bool=false
var state_time:float

func enter() -> void:
	super.enter()
	state_time=0.2
	player.velocity.y=0
	anim.play("Player_Hang")
	
	
func exit()->void:
	super.exit()
	if is_quit_climb:
		player.velocity.x=-player.facing_dir*20
	
##渲染帧触发
func pocess_update(delta: float)->void:
	super.pocess_update(delta)
	pass
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	super.physice_pocess_update(delta)
	##保持
	state_time-=delta
	if state_time<0:
		if player.direction.x==0:
			return
		if not player.is_movedir_sim_facedir():
			state_machine.change_state("AirState")
			is_quit_climb=true
			return
		elif player.is_movedir_sim_facedir() or player.direction.y>0:
			state_machine.change_state("ClimbState")
			return
