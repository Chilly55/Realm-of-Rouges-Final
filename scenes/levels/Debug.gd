extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var list_of_items = get_tree().get_nodes_in_group("item")
	var number_of_collectables = 0
	for item in list_of_items:
		if item.get_item().item_type == "collectable":
			number_of_collectables += 1
	print(number_of_collectables)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
