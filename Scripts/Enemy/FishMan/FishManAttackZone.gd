extends Area2D

class_name FishManAttackZone

var fishman:FishMan

func _ready() -> void:
	fishman=get_parent().get_parent()
##碰到玩家
func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.name=="PlayerHitbox":
		fishman.hitplayer=true
		
