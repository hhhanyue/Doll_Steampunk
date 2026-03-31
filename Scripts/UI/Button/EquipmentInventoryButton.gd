extends Button

class_name EquipmentInventoryButton

var current_item:InventoryItem=null
@export var index:int

func _on_pressed() -> void:
	print("press")
	
##内置方法  拖动
func _get_drag_data(at_position: Vector2) -> Variant:
	if current_item == null: return null
	var preview = TextureRect.new()
	preview.texture = current_item.item.icon
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.custom_minimum_size = Vector2(40, 40)
	set_drag_preview(preview)
	return self

##内置方法 能否拖动
func _can_drop_data(at_position, data):
	return data is EquipmentInventoryButton
	
##内置方法  能否放下
func _drop_data(at_position, data):
	var source_slot = data # 拖过来的格子
	var target_slot = self # 当前被放下的格子
	Inventory.instance.switch_inventory_item(source_slot.index,target_slot.index)
