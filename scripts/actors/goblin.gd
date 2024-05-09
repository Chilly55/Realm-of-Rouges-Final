extends Actor

@export_category("Stats")
@export var _weapon:ItemResource

var target:Node2D = null
var can_fire = true

@onready var pointer:Pointer = $Pointer
@onready var timer = $Timer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	super()
	pointer.change_projectile(_weapon._projectile, _weapon.weapon_sprite)

func _physics_process(delta):
	if target:
		var target_position = target.global_position + Vector2(0, -32)
		pointer.point_pointer(target_position)
		sprite_2d.flip_h = true if target_position.x < global_position.x else false
		if can_fire:
			pointer.fire(target_position)
			can_fire = false
			timer.start()
	else:
		pointer.point_pointer(Vector2.UP + global_position)


func die():
	super()
	queue_free()


func _on_area_2d_body_entered(body):
	target = body
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	target = null
	pass # Replace with function body.


func _on_timer_timeout():
	can_fire = true
	pass # Replace with function body.
