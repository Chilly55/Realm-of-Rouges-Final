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


func fire_projectile():
	var new_projectile:BaseProjectile = project_scene.instantiate()
	new_projectile._projectile_resource = projectile
	emitter.add_child(new_projectile)
	var direction = (get_viewport().get_mouse_position() - emitter.global_position).normalized()
	new_projectile.set_up(emitter.global_position, direction)


func _input(event):
	if event.is_action_pressed("fire") and !disabled:
		fire_projectile()

func _physics_process(delta):
	look_at(get_viewport().get_mouse_position())
