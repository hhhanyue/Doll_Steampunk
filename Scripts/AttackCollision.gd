extends CollisionShape2D

class_name AttackCollision

func _enter_tree() -> void:
	self.disabled=true

func _disable_collision():
	self.disabled = true
	
func _enable_collision():
	self.disabled = false
