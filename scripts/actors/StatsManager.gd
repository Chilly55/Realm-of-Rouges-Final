extends Node
class_name StatsManager

@export var _actor_resource : ActorResource

# Stats
var health:int
var max_health: int
var speed: int

func _ready():
	health = _actor_resource.health
	max_health = _actor_resource.health
	speed = _actor_resource.speed
