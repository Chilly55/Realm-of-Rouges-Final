extends CharacterBody2D

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
	
func choose(array):
	array.shuffle() 
	return array.front() 
	
func _on_Timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose(IDLE) 

