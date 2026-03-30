extends Node2D

class_name PlayerHPUI

@onready var health_back:TextureProgressBar=$"HPBack"
@onready var health_front:TextureProgressBar=$"HPFront"

@onready var health_view:NinePatchRect=$"HPbarView"

@export var playerlift_per_pixel:float=5
var player:Player

var hp:int
var slowdow_hp:float=100

func _ready() -> void:
	##64为ninepatchrect与textureprogressbar的差距
	player=PlayerManger.instance.player
	health_back.size.x=playerlift_per_pixel*player.max_health
	health_front.size.x=playerlift_per_pixel*player.max_health
	health_view.size.x=playerlift_per_pixel*player.max_health+64
	hp=player.current_health
	change_max_life(hp)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		if player.current_health>0:
			player.current_health-=10
			change_life(player.current_health)
	if event.is_action_pressed("test1"):
		if player.current_health<player.max_health:
			player.current_health+=10
			change_life(player.current_health)

func change_life(health:float)->void:
	health_front.value=health
	if health>hp:
		slowdow_hp=health
		health_back.value=slowdow_hp
	hp=health
	
func change_max_life(maxhealth:float)->void:
	health_front.size.x=playerlift_per_pixel*maxhealth
	health_front.max_value=maxhealth
	health_back.size.x=playerlift_per_pixel*maxhealth
	health_back.max_value=maxhealth
	health_view.size.x=playerlift_per_pixel*maxhealth+64
	
func back_health_bar_down(delta:float,currenthp:float)->void:
	if health_back.value>currenthp:
		health_back.value=slowdow_hp
		slowdow_hp-=3*delta
	
func _physics_process(delta: float) -> void:
	back_health_bar_down(delta,hp)
