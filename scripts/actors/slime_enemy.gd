extends Actor

var speed = 40
var player_chase = false 
var player = null 

@onready var animated_sprite_2d = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if player_chase:
		position += (player.position - position ) / speed 
		
		animated_sprite_2d.flip_h = true if (player.position.x - position.x) < 0 else false
		animated_sprite_2d.play("Walk") 
	else:
		animated_sprite_2d.play("Idle")
	
	if !is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	move_and_slide()

func die():
	super()
	queue_free()

func _on_collision_area_body_entered(body):
	player = body 
	player_chase = true 


func _on_collision_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	player = null 
	player_chase = false 
