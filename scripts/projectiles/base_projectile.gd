extends RigidBody2D
class_name BaseProjectile

@export var _projectile_resource:ProjectileResource
@export var projectile_collison_box:Area2D

@export var projectile_force : float
@export_flags_2d_physics var collison = 0b0000
@onready var area_2d = $Area2D


func set_up(pos:Vector2, direction:Vector2):
	position = pos
	projectile_force = ((-2.0 * _projectile_resource.distance) / (_projectile_resource.life_time ** 2)) * -1
	linear_velocity = direction * projectile_force
	top_level = true


# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.collision_mask = collison
	gravity_scale = _projectile_resource.gravity
	var death_timer = Timer.new()
	add_child(death_timer)
	death_timer.timeout.connect(queue_free)
	death_timer.start(_projectile_resource.life_time)
	
	projectile_collison_box.body_entered.connect(die)

func die(_node):
	if _node is Actor:
		_node.change_health(-_projectile_resource.damage)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
