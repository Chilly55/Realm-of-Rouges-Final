extends AudioStreamPlayer2D
class_name DestroyPlayer

# Called when the node enters the scene tree for the first time.
func _init(audio, position):
	global_position = position
	stream = audio
	
func _ready():
	top_level = true
	play()
	finished.connect(destroy_self)

func destroy_self():
	queue_free()
