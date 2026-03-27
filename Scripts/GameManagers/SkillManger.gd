extends Node2D

class_name SkillManger

@export var dashcooldowntime:float=1
var dashcooldowntimer:float 
var player:Player

##skilllock
var lock_dash_skill:bool=true
var lock_doublejump_skill:bool=true

func _ready() -> void:
	dashcooldowntimer=dashcooldowntime
	player=PlayerManger.instance.player
	
func _physics_process(delta: float) -> void:
	if not lock_dash_skill:
		dashcooldowntimer-=delta
		if dashcooldowntimer<0:
			player.candash=true
		
func dash_in_cool()->void:
	player.candash=false
	dashcooldowntimer=dashcooldowntime
	
func dash_is_ready()->void:
	if not lock_dash_skill:
		player.candash=true
		dashcooldowntimer=0
	
