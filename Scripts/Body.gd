extends Node2D
##旋转物体
class_name Body
@onready var player: Player = $".."

func flip()->void:
	self.scale.x= -self.scale.x
	pass
