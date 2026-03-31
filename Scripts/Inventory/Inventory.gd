extends Node

class_name Inventory

@export var item:ItemData

var inventory_item_dictionary:Dictionary[ItemData,InventoryItem]
var inventory_item_list:Array[InventoryItem]

@export var equipment_inventory_item_list:Array[ItemData]=[null,null,null,null,null,null]

static var instance:Inventory

func _enter_tree():
	if instance == null:
		instance = self
	else:
		queue_free() 

func  _ready() -> void:
	inventory_item_dictionary={}
	inventory_item_list=[]
	for i in range(len(UIManger.instance.ui.backpack.get_children())):
		inventory_item_list.append(null)
	

##添加物品如果没有的物品就新建一个放字典
func add_item(_item_data:ItemData)->void:
	var item=inventory_item_dictionary.get(_item_data,null)
	if item==null:
		inventory_item_dictionary[_item_data]=InventoryItem.new(_item_data)
		for index in range(len(inventory_item_list)):
			if inventory_item_list[index]==null:
				inventory_item_list[index]=inventory_item_dictionary[_item_data]
				break
	else:
		inventory_item_dictionary[_item_data].add_stack()
		
##移除物品
func remove_item(_item_data:ItemData)->void:
	if inventory_item_dictionary[_item_data].itemcount>1:
		inventory_item_dictionary[_item_data].reduce_stack()
	else:
		inventory_item_list[inventory_item_dictionary[_item_data]]=null
		inventory_item_dictionary.erase(_item_data)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		add_item(item)
		
func switch_inventory_item(from:int,to:int)->void:
	if inventory_item_list[to]==null:
		inventory_item_list[to]=inventory_item_list[from]
		inventory_item_list[from]=null
	else:
		var temp=inventory_item_list[from]
		inventory_item_list[to]=inventory_item_list[from]
		inventory_item_list[from]=temp
	UIManger.instance.ui.update_backpack_ui()
	
