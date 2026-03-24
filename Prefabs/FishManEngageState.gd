extends FishManStateBase

class_name FishManEngageState

var min_player_distance:float=20
var max_player_distance:float=40
var should_keep_distance:float

var player_position:Vector2

func enter() -> void:
	super.enter()
	
func exit()->void:
	super.exit()
	
##渲染帧触发
func pocess_update(delta: float)->void:
	super.pocess_update(delta)
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	player_position=player.global_position
	print((player_position))
	super.physice_pocess_update(delta)
	
	
func keeping_distance_with_player()->void:
	should_keep_distance=randi_range(min_player_distance, max_player_distance)
	
func move_to_player()->void:
	fishman.velocity
