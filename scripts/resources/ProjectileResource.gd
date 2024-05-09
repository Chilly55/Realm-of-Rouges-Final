extends Resource
class_name ProjectileResource

@export_category("Statistics")
@export var life_time:= 5.0
@export var damage:= 1 
@export var distance := 600
@export var gravity := 1.0
@export_category("sounds")
@export var spawn_sound:AudioStream
@export var hit_sound:AudioStream
@export_category("sprites")
@export var sprite:Texture
