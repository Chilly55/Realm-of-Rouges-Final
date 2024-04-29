extends CharacterBody2D

@export_category("Stats")
@export var stats_manager:StatsManager
@export var _weapon:ItemResource

var target:Node2D = null
var can_fire = true

@onready var pointer:Pointer = $Pointer
@onready var timer = $Timer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pointer.change_projectile(_weapon._projectile)

func _physics_process(delta):
	if target:
		pointer.point_pointer(target.global_position)
		if can_fire:
			pointer.fire(target.global_position)
			can_fire = false
			timer.start()
	else:
		pointer.point_pointer(Vector2.UP + global_position)


func _on_area_2d_body_entered(body):
	target = body
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	target = null
	pass # Replace with function body.


func _on_timer_timeout():
	can_fire = true
	pass # Replace with function body.
