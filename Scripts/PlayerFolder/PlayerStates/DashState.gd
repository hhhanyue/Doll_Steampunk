extends PlayerStateBase

class_name DashState

var dashstatetime:float=0.1
var dashstatetimer:float

func enter() -> void:
	dashstatetimer=dashstatetime
	
	
func exit()->void:
	if not player.is_in_ground():
		SkillManger.instance.dash_in_cool()
	
	
##渲染帧触发
func pocess_update(delta: float)->void:
	pass
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	player.velocity=Vector2( player.speed*player.facing_dir*delta*player.dash_speed_muti,0)
	dashstatetimer-=delta
	if dashstatetimer<0:
		state_machine.change_state("IdleState")
	player.move_and_slide()
