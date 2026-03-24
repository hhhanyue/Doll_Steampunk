extends Enemy

class_name  FishMan

@export var partol_point:Node

var points:Array[Marker2D]
var points_pos:Array[Vector2]
var target_pos:Vector2
var point_size:int
var point_index:int
var is_ascend:bool=true

func _ready() -> void:
	init_points()
	
##敌人离标记点是否够近
##point_index代表巡逻点
##从正序到逆序循环
func Enemy_Near_Point()->bool:
	if self.global_position.distance_to(target_pos)<3:
		if is_ascend:
			point_index+=1
		else:
			point_index-=1
		if point_index>point_size-1:
			point_index=point_size-2
			is_ascend=false
		if point_index<0:
			point_index=1
			is_ascend=true
		target_pos=points_pos[point_index]
		return true
	return false
	
##初始化巡逻点
func init_points()->void:
	var points=partol_point.get_children()
	point_size=points.size()
	for i in range(point_size):
		points_pos.append(points[i].global_position)
	target_pos=points_pos[0]
	point_index=0
