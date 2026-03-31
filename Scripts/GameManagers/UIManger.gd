extends Node2D

class_name UIManger

static var instance:UIManger

@export var ui:UI
var is_display:bool=false


func _enter_tree():
	if instance == null:
		instance = self
	else:
		queue_free() 

func switch_ui_display()->void:
	if not is_display:
		ui.visible=true
		ui.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		ui.visible=not ui.visible
		ui.process_mode = Node.PROCESS_MODE_DISABLED
	is_display=not is_display
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("switch_menu"):
		switch_ui_display()
