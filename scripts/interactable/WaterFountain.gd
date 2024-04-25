extends StaticBody2D
class_name Fountain

@export var amount_given:= 1
@export var interval:= 0.5

var player:CharacterBody2D= null
var timer:Timer

func _ready():
	var new_timer = Timer.new()
	new_timer.wait_time = interval
	timer = new_timer
	add_child(new_timer)
	new_timer.timeout.connect(give_water)
	

func give_water():
	player.change_water_amount(amount_given)
	print('end')
	timer.start(interval)
	


func _on_area_2d_body_entered(body):
	player = body
	print('start')
	timer.start()


func _on_area_2d_body_exited(body):
	player = null
	timer.stop()
	


