extends Button

class_name EquipmentNaviButton

@export var control_inventory:Control

func _on_pressed() -> void:
	UIManger.instance.ui.switch_equipment_layout_ui(control_inventory)
