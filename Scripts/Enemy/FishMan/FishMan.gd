extends Enemy

class_name  FishMan

@export var partol_point:Node

##巡逻用变量
var points:Array[Marker2D]
var points_pos:Array[Vector2]
var target_pos:Vector2
var point_size:int
var point_index:int
var is_ascend:bool=true

##攻击用变量
var attacktimer:float
var attack1_probability:int=70;
var current_attack1_probability:int=70;
var attack_cooldowncount:float=1
var current_attack_cooldowncount:float=1
##是否攻击到玩家
var hitplayer:bool=false
##鱼人攻击力
@export var fishman_damage:float=20

func _ready() -> void:
	super._ready()
	init_points()
	state_machine.enemy_ready()
	
func _process(delta: float) -> void:
	state_machine.enemy_process(delta)
	
func _physics_process(delta: float) -> void:
	state_machine.enemy_physics_process(delta)
	current_attack_cooldowncount-=delta
	
##敌人离标记点是否够近
##point_index代表巡逻点
##从正序到逆序循环
func Enemy_Near_Point()->bool:
	if self.global_position.distance_to(target_pos)<10:
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
	
##随机攻击类型
func random_attack_type()->String:
	var attack_probability=randi_range(1,100)
	if attack_probability<current_attack1_probability:
		current_attack1_probability=attack1_probability
		return "FishMan_Attack1"
	current_attack1_probability-=10
	return "FishMan_Attack2"
		
#动画中调用，攻击结束
func _attack_finish():
	current_attack_cooldowncount=attack_cooldowncount
	self.state_machine.change_state("FishManPatrolState")
	
