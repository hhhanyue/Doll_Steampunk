extends Node

class_name InventoryItem

@export var item:ItemData
##物品数量
var itemcount:int=0

func _init(_item:ItemData) -> void:
	item=_item
	itemcount=1
	
func add_stack()->void:
	itemcount+=1
	
func reduce_stack()->void:
	itemcount-=1
