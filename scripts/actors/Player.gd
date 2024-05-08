extends Actor

# map
@export var map:BaseMap
@export_category("Inventory")
@export var _weapons:Array[ItemResource]
@export var _abilities:Array[ItemResource]
@export_category("Stats")
var jump_count = 0 :
	set(value):
		jump_count = value
		jump_change.emit()
@export var jump_count_max = 1
@export_subgroup("Water")
@export var can_use_water := true
@export var water_capacity := 20 :
	set(value):
		water_capacity = value
		water_compacity_change.emit()
@export var water_limit := 20


@onready var jump_velocity : float = ((2.0 * _actor_resource.jump_height) / _actor_resource.acenstion_time) * -1
@onready var jump_gravity : float = ((-2.0 * _actor_resource.jump_height) / (_actor_resource.acenstion_time)) * -1
@onready var fall_gravity : float = ((-2.0 * _actor_resource.jump_height) / (_actor_resource.decension_time ** 2)) * -1


var weapon_index := 0
var face_direction := 1

# Labels
@onready var weapon := $CanvasLayer/Stats/weapon
@onready var jump_count_label := $CanvasLayer/Stats/JumpCountLabel
@onready var water := $CanvasLayer/Stats/Water
@onready var health_label = $CanvasLayer/Stats/health
@onready var count = $CanvasLayer/count

# Nodes
@onready var sprite_2d := $Sprite2D
@onready var sprite_2d_2 = $Sprite2D2

@onready var pointer:Pointer = $Pointer

signal jump_change()
signal water_compacity_change()


func _ready():
	super()
	change_weapon()
	update_health_counter()
	update_jump_counter()
	update_water_container_counter()
	
	jump_change.connect(update_jump_counter)
	water_compacity_change.connect(update_water_container_counter)
	health_changed.connect(update_health_counter)
	map.count_changed.connect(func(text): count.text = text)


func _input(event):
	if event.is_action_pressed("fire") and !pointer.disabled:
		var gun_uses_water:bool = (get_current_gun().ammo_type == 'water' and water_capacity > 0)
		var gun_uses_no_ammo:bool = get_current_gun().ammo_type == 'none'
		if gun_uses_water or gun_uses_no_ammo:
			pointer.fire(get_global_mouse_position())
			if gun_uses_water:
				change_water_amount(-1)
		
	if event.is_action_pressed("next weapon"):
		change_weapon_index(1)
	elif event.is_action_pressed("last weapon"):
		change_weapon_index(-1)


func _physics_process(delta):
	pointer.point_pointer(get_global_mouse_position())
	sprite_2d_2.look_at(get_global_mouse_position())
	
	jump_controls(delta)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * _actor_resource.speed
		face_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, _actor_resource.speed)

	move_and_slide()

func jump_controls(delta):
	if not is_on_floor():
		if jump_count == 0:
			jump_count = 1
		velocity.y -= get_gravity() * delta
	else:
		jump_count = 0

	if Input.is_action_just_pressed("jump") and (is_on_floor() or jump_count < jump_count_max):
		jump_count += 1
		velocity.y = _actor_resource.jump_height
	elif Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = 0


func get_gravity():
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func _process(delta):
	var point_direction = (global_position - get_global_mouse_position()).normalized().x
	var corrected_direction = 1 if point_direction > 0 else -1
	sprite_2d.flip_h = true if corrected_direction == 1 else false
	sprite_2d_2.flip_v = true if corrected_direction == 1 else false
	
	var speed_dis = clamp((face_direction * corrected_direction) * -1, -1, 1)
	if velocity.x != 0:
		sprite_2d.play("walk", speed_dis)
	else:
		sprite_2d.play("default")
	pass


func change_water_amount(amount:int):
	water_capacity = clamp(water_capacity + amount, 0, water_limit)
	water.text = "Water: %d / %d" % [water_capacity, water_limit]


func get_current_gun():
	return _weapons[weapon_index]


func change_weapon():
	if _weapons.size() == 0:
		pointer.disable_pointer(true)
	else:
		pointer.change_projectile(get_current_gun()._projectile)
		weapon.text = "Weapon: %s" % _weapons[weapon_index].item_name


func change_weapon_index(index_offset:int):
	weapon_index += index_offset
	weapon_index %= _weapons.size()
	change_weapon()


func update_jump_counter():
	jump_count_label.text = "Jump count: %d / %d" % [jump_count, jump_count_max]


func update_water_container_counter():
	water.text = "Water: %d / %d" % [water_capacity, water_limit]


func update_health_counter():
	health_label.text = "Health: %d / %d" %  [health, max_health]


func _on_pick_up_finder_body_entered(body):
	var item:ItemResource = body.get_item()
	if item.item_type == 'weapon' and item not in _weapons:  # If the item is a weapon
		_weapons.append(item)
		weapon_index = _weapons.size() - 1
		change_weapon()
	if item.item_type == "ability" and item not in _abilities:  # if the item is an ability
		_abilities.append(item)
		if item.unlock_water:
			can_use_water = true
		if item.double_jump:
			jump_count_max += 1
		
	body.queue_free()
