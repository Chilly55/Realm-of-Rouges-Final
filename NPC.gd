extends CharacterBody2D
@onready var timer = $Timer
@onready var dialogue_box = $"Dialogue Box"

enum {
	IDLE,
	NEW_DIR,
	MOVE,
	DIALOGUE
}

const speed = 0 
var current_state = IDLE 
var dir = Vector2.RIGHT

func _process(delta):
	match current_state:
		IDLE:
			pass
		
		MOVE:
			move(delta) 

func move(delta):
	position =+ dir * speed * delta

func interaction():
	dialogue_box._npc_interaction()
	dialogue_box.visible = true
	timer.start()
	
func choose(array):
	array.shuffle() 
	return array.front() 
	
func _on_Timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose(IDLE)

func _on_timer_timeout():
	dialogue_box.visible = false
	pass # Replace with function body.
