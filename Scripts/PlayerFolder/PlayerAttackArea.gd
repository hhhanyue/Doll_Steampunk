extends Area2D

class_name PlayerAttackArea

var player:Player

func _ready() -> void:
	player=PlayerManger.instance.player


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.name=="EnemyHitbox":
		player.attack_enemy(area.get_parent().get_parent())
