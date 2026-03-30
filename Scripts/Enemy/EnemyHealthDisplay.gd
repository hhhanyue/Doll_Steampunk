extends Node2D

class_name EnemyHealthDisplay

var enemy:Enemy
var greatnode:ColorRect
var notbadnode:ColorRect
var dangernode:ColorRect

func _ready() -> void:
	enemy=get_parent().get_parent()
	for node in get_children():
		if node.name=="great":
			greatnode=node
		if node.name=="notbad":
			notbadnode=node
		if node.name=="danger":
			dangernode=node

func switch_health_display()->void:
	if enemy.current_health/enemy.health>0.6:
		greatnode.show()
		notbadnode.show()
		dangernode.show()
	elif enemy.current_health/enemy.health>0.3:
		greatnode.hide()
		notbadnode.show()
		dangernode.show()
	else:
		greatnode.hide()
		notbadnode.hide()
		dangernode.show()
