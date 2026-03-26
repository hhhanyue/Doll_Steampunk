extends FishManStateBase

class_name FishManEngageState

var min_player_distance:float=3
var max_player_distance:float=10
var should_keep_distance:float

var player_position:Vector2
var confrontation_move_min_time:float=0.3
var confrontation_move_max_time:float=0.5
var confrontation_move_time:float=0.4
var confrontation_dir:int=1

func enter() -> void:
	fishman.velocity=Vector2.ZERO
	confrontation_move_time=randf_range(confrontation_move_min_time,confrontation_move_max_time)
	super.enter()
	
func exit()->void:
	super.exit()
	
##渲染帧触发
func pocess_update(delta: float)->void:
	super.pocess_update(delta)
	
##物理帧触发
func physice_pocess_update(delta: float)->void:
	fishman.fall(delta)
	player_position=player.global_position
	var player_target_dir=player_in_lft_or_rig()
	move_to_player(delta,player_target_dir)
	super.physice_pocess_update(delta)
	
	
##向玩家移动
##距离很远就靠近，攻击距离就对峙，近距离就后退离开
func move_to_player(delta:float,player_target_dir:int)->void:
	fishman.velocity=Vector2.ZERO
	if not fishman.is_in_ground(fishman.ground_check_front):
		facing_player(player_target_dir)
		fishman.velocity=Vector2.ZERO
		return
	if player_position.distance_to(fishman.global_position)>max_player_distance:
		fishman.Move(delta,player_target_dir,fishman.speed)
		facing_forward()
	##可开始攻击
	elif player_position.distance_to(fishman.global_position)>min_player_distance:
		
		if fishman.current_attack_cooldowncount<0:
			state_machine.change_state(fishman.random_attack_type())
		confrontation(delta,is_back_no_ground())
		facing_player(player_target_dir)
	else:
		if not is_back_no_ground():
			fishman.Move(delta,-player_target_dir,fishman.speed/4)
		facing_player(player_target_dir)

	
##对峙
##随机前后移动的时间
##前后蠕动
func confrontation(delta:float,back_no_ground:bool)->void:
	confrontation_move_time-=delta
	if confrontation_move_time<0:
		confrontation_move_time=randf_range(confrontation_move_min_time,confrontation_move_max_time)
		confrontation_dir*=-1
	else:
		if confrontation_dir==player_in_lft_or_rig() and not back_no_ground:
			pass
		else:
			fishman.Move(delta,confrontation_dir,fishman.speed/7)
	
func is_back_no_ground()->bool:
	if not fishman.is_in_ground(fishman.ground_check_back):
		return true
	return false
