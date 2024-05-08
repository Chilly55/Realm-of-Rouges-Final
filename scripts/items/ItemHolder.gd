extends StaticBody2D
class_name ItemHolder

@export var _item:ItemResource

@onready var sprite_2d = $Sprite2D

func get_item():
	if _item.item_type == "collectable":
		SignalBus.item_collected.emit()
	return _item

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = _item.pick_up_sprite
