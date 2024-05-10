extends Button
class_name ChangeSceneButton

@export_file() var scene 

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(func():
		get_tree().change_scene_to_file(scene)
		)
