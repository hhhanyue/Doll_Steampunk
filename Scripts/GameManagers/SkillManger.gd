extends Node2D

class_name SkillManger

static var instance:SkillManger

func _enter_tree():
	if instance == null:
		instance = self
	else:
		queue_free() 

@export var dashcooldowntime:float=1
var dashcooldowntimer:float 
var player:Player

##skilllock
@export var lock_dash_skill:bool=true
@export var lock_doublejump_skill:bool=true

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
	
