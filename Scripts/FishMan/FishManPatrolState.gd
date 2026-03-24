extends FishManStateBase

class_name FishManPatrolState

func enter() -> void:
	super.enter()
	anim.play("FishMan_Patrol")
	
func exit()->void:
	super.exit()
	
##渲染帧触发
func pocess_update(delta: float)->void:
	super.pocess_update(delta)
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	fishman.Move(delta)
	fishman.fall(delta)
	facing_forward()
	if fishman.Enemy_Near_Point():
		fishman.facing_direction*=-1
		
	super.physice_pocess_update(delta)
