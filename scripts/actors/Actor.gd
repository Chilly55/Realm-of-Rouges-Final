extends CharacterBody2D
class_name Actor

@export var _actor_resource:ActorResource
var health:int :
	set(value):
		health = value
		health_changed.emit()
var max_health:int

signal health_changed()

func _ready():
	health = _actor_resource.health
	max_health = _actor_resource.health


func change_health(health_change:int):
	health = clamp(health + health_change, 0, max_health)
	
	if dead():
		die()


func dead():
	return true if health == 0 else false

func die():
		print(dead)
