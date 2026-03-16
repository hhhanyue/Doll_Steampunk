extends GroundState

class_name IdleState

##玩家节点


func enter()->void:
	super.enter()
	anim.play("Player_Idle")
	
func pocess_update(delta: float) -> void:
	super.pocess_update(delta)
func physice_pocess_update(delta: float)->void:
	super.physice_pocess_update(delta)
	if player.direction.x!=0:
		state_machine.change_state("MoveState")
	
func exit()->void:
	super.exit()
