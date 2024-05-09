@tool
extends Resource
class_name ItemResource

@export_category("Information")
@export var item_name:String
@export_enum("collectable", "ability", "weapon") var item_type = "collectable":
	set(value):
		item_type = value
		notify_property_list_changed()
@export_category("Statistics")
## Abilities
@export var unlock_water := true
@export var double_jump := true
## Weapons
@export var _projectile:ProjectileResource
@export_enum('none', 'water') var ammo_type = 'none'
@export_category("Sprites")
@export var pick_up_sprite:CompressedTexture2D
# Weapons
@export var weapon_sprite:CompressedTexture2D
@export_category("Sounds")
@export var pick_up_sound:AudioStream


func _validate_property(property):
	if property.name in ['unlock_water', 'double_jump'] and item_type != "ability":
		property.usage = PROPERTY_USAGE_NO_EDITOR
	if property.name in ['_projectile', 'weapon_sprite', 'ammo_type'] and item_type != 'weapon':
		property.usage = PROPERTY_USAGE_NO_EDITOR

"""
https://github.com/godotengine/godot-proposals/issues/1056
How to hide properties
"""
