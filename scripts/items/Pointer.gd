extends CharacterBody2D
class_name Pointer

@onready var emitter = $Emitter

@onready var project_scene = preload("res://scenes/items/test_projectile.tscn")
@onready var sprite_2d = $Sprite2D

var projectile:ProjectileResource
var disabled = true

func disable_pointer(disable:bool):
	disabled = disable
	sprite_2d.visible = !disable

func change_projectile(projectile_resource:ProjectileResource):
	projectile = projectile_resource
	disable_pointer(false)


func fire_projectile(target:Vector2):
	var new_projectile:BaseProjectile = project_scene.instantiate()
	new_projectile._projectile_resource = projectile
	emitter.add_child(new_projectile)
	var direction = (target - emitter.global_position).normalized()
	new_projectile.set_up(emitter.global_position, direction)

func fire(target:Vector2):
	if !disabled:
		fire_projectile(target)

func point_pointer(target:Vector2):
	look_at(target)
