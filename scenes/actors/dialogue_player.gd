extends CanvasLayer

@export var BaseMap 

var meet_for_first_time  
var dialogue = []
var current_dialogue_id = 0 
var d_active = false 
var collect_number
var number_of_collectables 


func _npc_interaction():
	if not meet_for_first_time:
		meet_for_first_time = true
		$DialogueText.text = "<Hello Traveler, we need you to resue the villagers!>"
	elif collect_number < number_of_collectables:
		$DialogueText.text = "<People are still missing>"
	elif collect_number >= number_of_collectables:
		$DialogueText.text = "<You saved everyone>"

func _ready():
	$NinePatchRect.visible = false 
	
func start():
	if d_active:
		return 
	d_active = true 
	$NinePatchRect.visible = true 

# Victory screen 
func _on_npc_You_saved_everyone():
	


