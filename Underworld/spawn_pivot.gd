extends Node2D

#This controls the spawn of the asteroids. 

#This references the asteroids for this code to work
@onready var  imp = preload("res://Enemies/imp.tscn")
@onready var floater = preload("res://Enemies/floater.tscn")
@onready var sage = preload("res://sage.tscn")
@export var max_floater = 2
@export var floater_container : Node2D
@export var max_sage = 2
@export var sage_container : Node2D
@export var spawn_container : Node2D
@export_group("Imp")
@export var imp_container : Node2D
@export var max_imp = 5
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
	if floater_container.get_child_count() < max_floater:
		var rand_rot = randf_range(0,360)
		rotation_degrees = rand_rot
		var new_floater = floater.instantiate()
		new_floater.global_position = $Marker2D.global_position
		spawn_container.add_child(new_floater)

#Where imp spawns
func spawn_imp():

	if imp_container.get_child_count() < max_imp:
		#This allows for multiple asteroid to spawn 
		var rand_rot = randf_range(0,360)
		rotation_degrees = rand_rot
		var new_imp = imp.instantiate()
		new_imp.global_position = $Marker2D.global_position
		
		imp_container.add_child(new_imp)

func spawn_sage():
	if sage_container.get_child_count() < max_sage:
		var rand_rot = randf_range(0,360)
		rotation_degrees = rand_rot
		var new_sage = sage.instantiate()
		new_sage.global_position = $Marker2D.global_position
		
		spawn_container.add_child(new_sage)
pass 
#Imp Spawn timer
func _on_timer_timeout() -> void:
	if Global.curr_imp < Global.max_imp:
		spawn_imp()
		
		
	else: 
		if Global.curr_imp>=Global.max_imp:
			$"imp timer".stop()
			print("max imp")
		pass # Replace with function body.
	
	pass # Replace with function body.

#Floater spawn timer
func _on_floater_timer_timeout() -> void:
	spawn_floater()
	pass # Replace with function body.


func _on_wave_1_timeout() -> void:
	
	$"Wave 2".start()
	
	max_imp += 8
	
	$"floater timer".start()
	
	print("wave 2 start")
	
	pass # Replace with function body.


func _on_sage_timer_timeout() -> void:
	if Global.curr_sage < max_sage :
		spawn_floater()
		
		
	elif Global.curr_sage>=max_sage:
		$"Sage timer".stop()
		
		pass # Replace with function body.
	
	
	pass # Replace with function body.
