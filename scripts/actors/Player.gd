extends CharacterBody2D

@export_category("Inventory")
@export var _weapons:Array[ItemResource]
@export var _abilities:Array[ItemResource]
@export_category("Stats")
@export var stats_manager:StatsManager

@onready var pointer:Pointer = $Pointer

var weapon_index := 0
const JUMP_VELOCITY = -400.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	change_weapon()

func change_weapon_index(index_offset:int):
	weapon_index += index_offset
	if weapon_index > _weapons.size() - 1:
		weapon_index = 0
	elif weapon_index < 0:
		weapon_index = _weapons.size() -1
	change_weapon()

func change_weapon():
	if _weapons.size() == 0:
		pointer.disable_pointer(true)
	else:
		pointer.change_projectile(_weapons[weapon_index]._projectile)

func _input(event):
	if event.is_action_pressed("next weapon"):
		change_weapon_index(1)
	elif event.is_action_pressed("last weapon"):
		change_weapon_index(-1)


func _physics_process(delta):
	# Add the gravity.
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = 0
	
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * stats_manager.speed
	else:
		velocity.x = move_toward(velocity.x, 0, stats_manager.speed)

	move_and_slide()
