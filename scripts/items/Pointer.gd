extends CharacterBody2D
class_name Pointer
@export_flags_2d_physics var collison = 0b0000

@onready var emitter = $Emitter

@onready var project_scene = preload("res://scenes/items/base_projectile.tscn")
@onready var sprite_2d = $Sprite2D

var projectile:ProjectileResource
var disabled = true

func _process(delta):
	var point_direction = (global_position - emitter.global_position).normalized().x
	sprite_2d.flip_v = true if point_direction > 0 else false

func disable_pointer(disable:bool):
	disabled = disable
	sprite_2d.visible = !disable

func change_projectile(projectile_resource:ProjectileResource, texture:Texture):
	if texture:
		sprite_2d.texture = texture
	projectile = projectile_resource
	disable_pointer(false)


func fire_projectile(target:Vector2):
	var new_projectile:BaseProjectile = project_scene.instantiate()
	new_projectile._projectile_resource = projectile
	new_projectile.collison = collison
	emitter.add_child(new_projectile)
	var direction = (target - emitter.global_position).normalized()
	new_projectile.set_up(emitter.global_position, direction)

func fire(target:Vector2):
	if !disabled:
		fire_projectile(target)

func point_pointer(target:Vector2):
	look_at(target)
