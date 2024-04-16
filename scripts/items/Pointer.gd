extends CharacterBody2D

@onready var emitter = $Emitter

@onready var project_scene = preload("res://scenes/items/test_projectile.tscn")

func _input(event):
	if event.is_action_pressed("fire"):
		var new_projectile:BaseProjectile = project_scene.instantiate()
		emitter.add_child(new_projectile)
		var direction = (get_viewport().get_mouse_position() - emitter.global_position).normalized()
		new_projectile.set_up(emitter.global_position, direction)

func _physics_process(delta):
	look_at(get_viewport().get_mouse_position())
