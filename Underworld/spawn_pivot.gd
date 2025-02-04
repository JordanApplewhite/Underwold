extends Node2D

#This controls the spawn of the asteroids. 

#This references the asteroids for this code to work
@onready var  imp = preload("res://Enemies/imp.tscn")
var max_imp = 5



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	pass





func spawn():

	
	#This allows for multiple asteroid to spawn 
	var rand_rot = randf_range(0,360)
	rotation_degrees = rand_rot
	var new_imp = imp.instantiate()
	new_imp.global_position = $Marker2D.global_position
	
	get_tree().get_root().add_child(new_imp)

#Spawn a new asteroid every 1-3 seconds.




func _on_timer_timeout() -> void:
	
	if Global.curr_imp < max_imp:
		spawn()
		
		
	elif Global.curr_imp>=max_imp:
		#$Timer.stop()
		
		pass # Replace with function body.
	

pass
	
