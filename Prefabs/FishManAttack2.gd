extends FishManStateBase

class_name FishManAttack2

func enter() -> void:
	anim.play("FishMan_Attack_2")
	
func exit()->void:
	pass
	
##渲染帧触发
func pocess_update(delta: float)->void:
	pass
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	pass
