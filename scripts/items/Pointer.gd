extends CharacterBody2D

@onready var emitter = $Emitter

@onready var project_scene = preload("res://scenes/items/test_projectile.tscn")

func _input(event):
	if event.is_action_pressed("fire"):
		var new_projectile:RigidBody2D = project_scene.instantiate()
		emitter.add_child(new_projectile)
		new_projectile.position = emitter.global_position
		var direction = (get_viewport().get_mouse_position() - emitter.global_position).normalized() * 600
		print(direction)
		new_projectile.linear_velocity = direction
		new_projectile.top_level = true
		
		

func _physics_process(delta):
	look_at(get_viewport().get_mouse_position())
