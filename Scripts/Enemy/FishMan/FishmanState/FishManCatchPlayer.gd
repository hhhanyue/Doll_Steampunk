extends FishManStateBase

class_name FishManCatechPlayer

var grabpoint:Marker2D
	
func _enter_tree() -> void:
	##获取grabpoint，有更好方案，但要改很多脚本，摆了
	var fishman=get_parent().get_parent()
	grabpoint=fishman.get_node("Body/GrabPoint")

func enter() -> void:
	anim.play("Grap_Player")
	
func exit()->void:
	pass
	
##渲染帧触发
func pocess_update(delta: float)->void:
	pass
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	player.global_position=grabpoint.global_position
	pass
