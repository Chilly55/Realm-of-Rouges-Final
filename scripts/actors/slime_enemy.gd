extends Actor

var speed = 40
var player_chase = false 
var player = null 

@onready var animated_sprite_2d = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

func _physics_process(delta):
	if player_chase:
		position += (player.position - position ) / speed 
		
		animated_sprite_2d.flip_h = true if (player.position.x - position.x) > 0 else false
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
	var new_destry_player:DestroyPlayer = DestroyPlayer.new(audio_stream_player_2d.stream, global_position)
	get_parent().add_child(new_destry_player)


func _on_collision_area_body_entered(body):
	player = body 
	player_chase = true 


func _on_collision_area_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	player = null 
	player_chase = false 

func change_health(number):
	super(number)
	audio_stream_player_2d.play()


func _on_player_detector_body_entered(body):
	if body is Actor:
		audio_stream_player_2d.play()
		var player:Actor = body
		body.change_health(-1)
