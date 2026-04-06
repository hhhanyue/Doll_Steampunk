extends Control

class_name UI

@export var equipment:Control
var equipment_slots:Array[Button]

@export var equipment_inventory_list:Array[Control]
@export var default_icon:Texture2D

enum InventoryType{NearAttack,FarAttack,BuffAttack}

var current_inventory_type:InventoryType=InventoryType.NearAttack

var equipment_inventory_index:Array[int]=[0,0,0]
var equipment_inventory_slots:Array[Array]
@export var equipment_inventory_navi:Control

var equipment_inventory_slot = preload("res://Prefabs/equipment_inventory.tscn")
@export var itemdata:ItemData

func _ready() -> void:
	equipment_slots=[]
	for slot in equipment.get_children():
		if slot is Button:
			equipment_slots.append(slot)
	for i in range(3):
		equipment_inventory_slots.append(equipment_inventory_list[i].get_children())
	equipment_inventory_index[0]=create_new_equipmentinventory_slot(equipment_inventory_list[0],Inventory.instance.nearattack_equipment_item_list,Inventory.instance.nearattack_equipment_item_dictionary,equipment_inventory_index[0],equipment_inventory_slots[0])
	equipment_inventory_index[1]=create_new_equipmentinventory_slot(equipment_inventory_list[1],Inventory.instance.farattack_equipment_item_list,Inventory.instance.farattack_equipment_item_dictionary,equipment_inventory_index[1],equipment_inventory_slots[1])
	equipment_inventory_index[2]=create_new_equipmentinventory_slot(equipment_inventory_list[2],Inventory.instance.buffattack_equipment_item_list,Inventory.instance.buffattack_equipment_item_dictionary,equipment_inventory_index[2],equipment_inventory_slots[2])
	switch_equipment_layout_ui(equipment_inventory_navi.get_children()[0])
	#remove_equipmentinventory_slot(Inventory.instance.nearattack_equipment_item_list,equipment_inventory_index[0],equipment_inventory_slots[0])
			
func update_equipment_ui()->void:
	var equipment_inventory:Array[InventoryItem]=Inventory.instance.equipment_inventory_item_list
	var index=0
	for slot:EquipmentButton in equipment_slots:
		if equipment_inventory[index]!=null:
			slot.current_item=equipment_inventory[index]
			slot.icon=equipment_inventory[index].item.icon
		else:
			slot.current_item=null
			slot.icon=default_icon
		index+=1
		
func update_backpack_ui()->void:
	match current_inventory_type:
		InventoryType.NearAttack:
			update_solo_equipment_ui(Inventory.instance.nearattack_equipment_item_list,Inventory.instance.nearattack_equipment_item_dictionary,equipment_inventory_list[0])
		InventoryType.FarAttack:
			update_solo_equipment_ui(Inventory.instance.farattack_equipment_item_list,Inventory.instance.farattack_equipment_item_dictionary,equipment_inventory_list[1])
			print(2)
		InventoryType.BuffAttack:
			update_solo_equipment_ui(Inventory.instance.buffattack_equipment_item_list,Inventory.instance.buffattack_equipment_item_dictionary,equipment_inventory_list[2])
	
func update_solo_equipment_ui(current_equipment_inventory_list:Array[InventoryItem],current_equipment_inventory_dictionary:Dictionary[ItemData,InventoryItem],current_equipment_inventory:Control)->void:
	var index=0
	var current_inventory_index=equipment_inventory_list.find(current_equipment_inventory)
	if current_inventory_index==-1:
		printerr("没有当前物品栏")
		return
	for node in current_equipment_inventory.get_children():
		var button:EquipmentInventoryButton
		var label:Label
		for subnode in node.get_children():
			if subnode is EquipmentInventoryButton:
				button=subnode
			if subnode is Label:
				label=subnode
		var itemdatainventory=current_equipment_inventory_list[index]
		if itemdatainventory!=null:
			button.icon=itemdatainventory.item.icon
			button.current_item=current_equipment_inventory_dictionary[itemdatainventory.item]
			if current_equipment_inventory_dictionary[itemdatainventory.item].itemcount!=1:
				label.text=str(current_equipment_inventory_dictionary[itemdatainventory.item].itemcount)
			else:
				label.text=""
		else:
			button.current_item=null
			button.icon=default_icon
			label.text=""
		index+=1
		
func create_new_equipmentinventory_slot(current_equipment_inventory:Control,current_inventory_item_list:Array[InventoryItem],current_inventory_item_dictionary:Dictionary[ItemData,InventoryItem],current_equipment_inventory_index:int,current_equipment_slots)->int:
	##引用形
	for i in range(6):
		current_inventory_item_list.append(null)
		var new_equipment_inventory_slot = equipment_inventory_slot.instantiate()
		var button:EquipmentInventoryButton=new_equipment_inventory_slot.get_node("Button")
		button.index=current_equipment_inventory_index
		if equipment_inventory_list.find(current_equipment_inventory)==0:
			button.buttontype="Near"
		elif equipment_inventory_list.find(current_equipment_inventory)==1:
			button.buttontype="Far"
		elif equipment_inventory_list.find(current_equipment_inventory)==2:
			button.buttontype="Buff"
		current_equipment_inventory_index+=1
		current_equipment_slots.append(new_equipment_inventory_slot)
		current_equipment_inventory.add_child(new_equipment_inventory_slot)
	return current_equipment_inventory_index
		
func remove_equipmentinventory_slot(current_inventory_item_list:Array[InventoryItem],current_equipment_inventory_index:int,current_equipment_inventory_slot)->void:
	for i in range(current_equipment_inventory_index-1,current_equipment_inventory_index-7,-1):
		current_inventory_item_list.remove_at(current_inventory_item_list.size()-1)
		current_equipment_inventory_slot[i].queue_free()
		current_equipment_inventory_index-=1

func switch_equipment_layout_ui(shownode:Control)->void:
	for equipment_inventory in equipment_inventory_navi.get_children():
		equipment_inventory.process_mode = Node.PROCESS_MODE_DISABLED
		equipment_inventory.hide()
	match equipment_inventory_navi.get_children().find(shownode):
		0:
			current_inventory_type=InventoryType.NearAttack
		1:
			current_inventory_type=InventoryType.FarAttack
		2:
			current_inventory_type=InventoryType.BuffAttack
		_:
			printerr("未找到当前显示节点类型")
	shownode.process_mode=Node.PROCESS_MODE_INHERIT
	shownode.show()
	update_backpack_ui()
	update_equipment_ui()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		Inventory.instance.equipment_inventory_item_list[2]=InventoryItem.new(itemdata)
		update_backpack_ui()
		update_equipment_ui()
