extends CharacterBody2D

@export_category("Inventory")
@export var _weapons:Array[ItemResource]
@export var _abilities:Array[ItemResource]
@export_category("Stats")
@export var stats_manager:StatsManager
var jump_count = 0
var jump_count_max = 1
@export_subgroup("Water")
@export var can_use_water := true
@export var water_capacity := 10
@export var water_limit := 10

@onready var pointer:Pointer = $Pointer

var weapon_index := 0
const JUMP_VELOCITY = -400.0

@onready var weapon = $CanvasLayer/Stats/weapon
@onready var jump_count_label = $CanvasLayer/Stats/JumpCountLabel
@onready var water = $CanvasLayer/Stats/Water


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	change_weapon()
	jump_count_label.text = "Jump count: %d / %d" % [jump_count, jump_count_max]
	water.text = "Water: %d / %d" % [water_capacity, water_limit]

func change_weapon_index(index_offset:int):
	weapon_index += index_offset
	weapon_index %= _weapons.size()
	change_weapon()

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

func _input(event):
	if event.is_action_pressed("fire"):
		var gun_uses_water:bool = (get_current_gun().ammo_type == 'water' and water_capacity > 0)
		var gun_uses_no_ammo:bool = get_current_gun().ammo_type == 'none'
		if gun_uses_water or gun_uses_no_ammo:
			pointer.fire()
			if gun_uses_water:
				change_water_amount(-1)
		
	if event.is_action_pressed("next weapon"):
		change_weapon_index(1)
	elif event.is_action_pressed("last weapon"):
		change_weapon_index(-1)


func _physics_process(delta):
	# Add the gravity.
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = 0
	
	if not is_on_floor():
		if jump_count == 0:
			jump_count = 1
		velocity.y += gravity * delta
		jump_count_label.text = "Jump count: %d / %d" % [jump_count, jump_count_max]
	else:
		jump_count = 0
		jump_count_label.text = "Jump count: %d / %d" % [jump_count, jump_count_max]

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or jump_count < jump_count_max):
		jump_count += 1
		jump_count_label.text = "Jump count: %d / %d" % [jump_count, jump_count_max]
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * stats_manager.speed
	else:
		velocity.x = move_toward(velocity.x, 0, stats_manager.speed)

	move_and_slide()


func _on_pick_up_finder_body_entered(body):
	var item:ItemResource = body.get_item()
	if item.item_type == 'weapon' and item not in _weapons:  # If the item is a weapon
		_weapons.append(item)
		weapon_index = _weapons.size() - 1
		change_weapon()
	if item.item_type == "ability" and item not in _abilities:  # if the item is an ability
		print(item.item_name)
		_abilities.append(item)
		if item.unlock_water:
			can_use_water = true
		if item.double_jump:
			jump_count_max += 1
		
		
	body.queue_free()
