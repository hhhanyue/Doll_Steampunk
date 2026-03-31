extends Control

class_name UI

@export var equipment:Control
@export var backpack:Control
@export var default_icon:Texture2D
var equipment_slots:Array[Button]
var backpack_slots:Array[Control]


func _ready() -> void:
	equipment_slots=[]
	for slot in equipment.get_children():
		if slot is Button:
			equipment_slots.append(slot)
	update_equipment_ui()
	for slot in backpack.get_children():
		backpack_slots.append(slot)
	update_backpack_ui()
	
##更新装备栏的UI
func update_equipment_ui()->void:
	var equipment_inventory=Inventory.instance.equipment_inventory_item_list
	var index=0
	for slot in equipment_slots:
		if equipment_inventory[index]!=null:
			slot.icon=equipment_inventory[index].icon
		index+=1
			
##更新背包的UI
func update_backpack_ui()->void:
	var backpack_inventory_list=Inventory.instance.inventory_item_list
	var backpack_inventory_dictionary=Inventory.instance.inventory_item_dictionary
	var index=0
	for itemdatainventory in backpack_inventory_list:
		
		var button:EquipmentInventoryButton
		var label:Label
		for node in backpack_slots[index].get_children():
			if node is EquipmentInventoryButton:
				button=node
			if node is Label:
				label=node
		if itemdatainventory!=null:
			button.icon=itemdatainventory.item.icon
			button.current_item=backpack_inventory_dictionary[itemdatainventory.item]
			if backpack_inventory_dictionary[itemdatainventory.item].itemcount!=1:
				label.text=str(backpack_inventory_dictionary[itemdatainventory.item].itemcount)
			else:
				label.text=""
		else:
			button.current_item=null
			button.icon=default_icon
			label.text=""
		index+=1
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		update_backpack_ui()
		
