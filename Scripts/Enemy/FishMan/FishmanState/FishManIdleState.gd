extends FishManStateBase

class_name FishManIdleState

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
