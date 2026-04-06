extends Node

class_name Inventory

@export var item:ItemData


var nearattack_equipment_item_dictionary:Dictionary[ItemData,InventoryItem]
var nearattack_equipment_item_list:Array[InventoryItem]
var farattack_equipment_item_dictionary:Dictionary[ItemData,InventoryItem]
var farattack_equipment_item_list:Array[InventoryItem]
var buffattack_equipment_item_dictionary:Dictionary[ItemData,InventoryItem]
var buffattack_equipment_item_list:Array[InventoryItem]

@export var equipment_inventory_item_list:Array[InventoryItem]=[null,null,null,null,null,null]

static var instance:Inventory

func _enter_tree():
	if instance == null:
		instance = self
	else:
		queue_free() 

func  _ready() -> void:

	init_inventory()
	
	##初始化
func init_inventory()->void:
	nearattack_equipment_item_dictionary={}
	nearattack_equipment_item_list=[]
	farattack_equipment_item_dictionary={}
	farattack_equipment_item_list=[]
	buffattack_equipment_item_dictionary={}
	buffattack_equipment_item_list=[]
	for j in range(len(UIManger.instance.ui.equipment_inventory_list[0].get_children())):
		add_null(nearattack_equipment_item_list)
	for j in range(len(UIManger.instance.ui.equipment_inventory_list[1].get_children())):
		add_null(farattack_equipment_item_list)
	for j in range(len(UIManger.instance.ui.equipment_inventory_list[2].get_children())):
		add_null(buffattack_equipment_item_list)

func add_null(inventory_item_list:Array[InventoryItem])->void:
	inventory_item_list.append(null)

##添加物品如果没有的物品就新建一个放字典
func add_item(_item_data:ItemData,inventory_item_list:Array[InventoryItem],inventory_item_dictionary:Dictionary[ItemData,InventoryItem])->void:
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
func remove_item(_item_data:ItemData,inventory_item_list:Array[InventoryItem],inventory_item_dictionary:Dictionary[ItemData,InventoryItem])->void:
	if inventory_item_dictionary[_item_data].itemcount>1:
		inventory_item_dictionary[_item_data].reduce_stack()
	else:
		##没找到
		##字典索引错误
		inventory_item_list[inventory_item_list.find(inventory_item_dictionary[_item_data])]=null
		inventory_item_dictionary.erase(_item_data)
		
		
func switch_inventory_item_outer(from:int,to:int,to_equip:bool,is_equip:bool,buttontype:String)->void:
	if buttontype=="Near":
		switch_inventory_item(from,to,to_equip,is_equip,nearattack_equipment_item_list,nearattack_equipment_item_dictionary)
		
func switch_inventory_item(from:int,to:int,to_equip:bool,is_equip:bool,inventory_item_list:Array[InventoryItem],inventory_item_dictionary:Dictionary[ItemData,InventoryItem])->void:
	##to_equip代表装备栏与物品栏
	##is_equip代表装备栏和物品栏内部
	if not to_equip:
		##内部交换
		if not is_equip:
			if inventory_item_list[to]==null:
				inventory_item_list[to]=inventory_item_list[from]
				inventory_item_list[from]=null
			else:
				var temp=inventory_item_list[to]
				inventory_item_list[to]=inventory_item_list[from]
				inventory_item_list[from]=temp
		else:
			if equipment_inventory_item_list[to]==null:
				equipment_inventory_item_list[to]=equipment_inventory_item_list[from]
				equipment_inventory_item_list[from]=null
			else:
				var temp=equipment_inventory_item_list[to]
				equipment_inventory_item_list[to]=equipment_inventory_item_list[from]
				equipment_inventory_item_list[from]=temp
	else:
		#装备栏和装备背包交换
		if is_equip:
			##送到装备栏
			if equipment_inventory_item_list[to]!=null:
				if inventory_item_dictionary.get(equipment_inventory_item_list[to].item,null)!=null:
					add_item(equipment_inventory_item_list[to].item,inventory_item_list,inventory_item_dictionary)
					equipment_inventory_item_list[to]=inventory_item_list[from]
					remove_item(inventory_item_list[from].item,inventory_item_list,inventory_item_dictionary)
					UIManger.instance.ui.update_backpack_ui()
					UIManger.instance.ui.update_equipment_ui()
					return
				if inventory_item_list[from].itemcount>1:
					add_item(equipment_inventory_item_list[to].item,inventory_item_list,inventory_item_dictionary)
					remove_item(inventory_item_list[from].item,inventory_item_list,inventory_item_dictionary)
					equipment_inventory_item_list[to]=inventory_item_list[from]
				else:
					inventory_item_dictionary[equipment_inventory_item_list[to].item]=equipment_inventory_item_list[to]
					equipment_inventory_item_list[to]=inventory_item_list[from]
					remove_item(inventory_item_list[from].item,inventory_item_list,inventory_item_dictionary)
			else:
				equipment_inventory_item_list[to]=inventory_item_list[from]
				remove_item(inventory_item_list[from].item,inventory_item_list,inventory_item_dictionary)
		else:
			##送到物品栏
			if inventory_item_dictionary.get(equipment_inventory_item_list[from].item,null)!=null:
				add_item(equipment_inventory_item_list[from].item,inventory_item_list,inventory_item_dictionary)
				equipment_inventory_item_list[from]=null
				UIManger.instance.ui.update_backpack_ui()
				UIManger.instance.ui.update_equipment_ui()
				return
			if inventory_item_list[to]==null:
				inventory_item_list[to]=equipment_inventory_item_list[from]
				inventory_item_dictionary[equipment_inventory_item_list[from].item]=equipment_inventory_item_list[from]                      
				equipment_inventory_item_list[from]=null
			else:
				##物品栏不为0
				if inventory_item_list[to].itemcount>1:
					add_item(equipment_inventory_item_list[from].item,inventory_item_list,inventory_item_dictionary)
					remove_item(inventory_item_list[to].item,inventory_item_list,inventory_item_dictionary)
					equipment_inventory_item_list[from]=inventory_item_list[to]
				else:
					var temp=inventory_item_list[to]
					remove_item(inventory_item_list[to].item,inventory_item_list,inventory_item_dictionary)
					inventory_item_list[to]=equipment_inventory_item_list[from]
					inventory_item_dictionary[inventory_item_list[to].item]=InventoryItem.new(inventory_item_list[to].item)
					equipment_inventory_item_list[from]=temp
	UIManger.instance.ui.update_backpack_ui()
	UIManger.instance.ui.update_equipment_ui()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		add_item(item,nearattack_equipment_item_list,nearattack_equipment_item_dictionary)
