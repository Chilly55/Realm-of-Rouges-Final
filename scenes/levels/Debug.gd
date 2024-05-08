extends Node2D
class_name BaseMap

var number_of_collectables:int
var collect_number:int

signal count_changed(text)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	SignalBus.item_collected.connect(func(): 
		collect_number += 1
		count_changed.emit("%d in danger " % (number_of_collectables - collect_number))
		)
		
	var list_of_items = get_tree().get_nodes_in_group("item")
	for item in list_of_items:
		if item._item.item_type == "collectable":
			print(item._item.item_name)
			number_of_collectables += 1
	
	count_changed.emit("%d in danger " % (number_of_collectables - collect_number))
