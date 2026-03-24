extends Node2D

class_name PlayerManger

static var instance:PlayerManger
var player:Player


func _enter_tree():
	if instance == null:
		instance = self
	else:
		queue_free() 
		
	player=self.get_parent().get_node("Player")
