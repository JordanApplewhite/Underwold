extends Node2D

#This controls the spawn of the asteroids. 

#This references the asteroids for this code to work
@onready var  imp = preload("res://Enemies/imp.tscn")
@onready var floater = preload("res://Enemies/floater.tscn")
var max_imp = 5
var max_floater = 3
var imp_can_spawn = true
var floater_can_spawn = true
@export var spawn_container : Node2D

var wave_1 = true
var wave_2 = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass

#Where floater spawns 
func spawn_floater():
	var rand_rot = randf_range(0,360)
	rotation_degrees = rand_rot
	var new_floater = floater.instantiate()
	new_floater.global_position = $Marker2D.global_position
	
	spawn_container.add_child(new_floater)

#Where imp spawns
func spawn_imp():

	
	#This allows for multiple asteroid to spawn 
	var rand_rot = randf_range(0,360)
	rotation_degrees = rand_rot
	var new_imp = imp.instantiate()
	new_imp.global_position = $Marker2D.global_position
	
	spawn_container.add_child(new_imp)

#Imp Spawn timer
func _on_timer_timeout() -> void:
	if Global.curr_imp < max_imp:
		spawn_imp()
		
		
	elif Global.curr_imp>=max_imp:
		#$Timer.stop()
		
		pass # Replace with function body.
	
	pass # Replace with function body.

#Floater spawn timer
func _on_floater_timer_timeout() -> void:
	
	if Global.curr_floater < max_floater :
		spawn_floater()
		print("floater spawned")
		
	elif Global.curr_floater>=max_floater:
		$"floater timer".stop()
		print("Max floater")
		pass # Replace with function body.
	
	
	pass # Replace with function body.

func _on_wave_1_timeout() -> void:
	wave_2 = true
	
	$"Wave 2".start()
	
	max_imp += 8
	
	$"floater timer".start()
	
	print("wave 2 start")
	
	pass # Replace with function body.
