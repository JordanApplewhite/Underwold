extends CharacterBody2D

@export var health = 5
@export var speed = 100
var accel = 7
@export var knockback: float = 300
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var health_bar: ProgressBar = $HealthBar
var type = "imp"
var damage = 2


#Referance to player
var player = preload("res://Player/player.tscn")



func _ready() -> void:
#	This rotates the imp fixes the imps rotation to face the player
	
	$Sprite2D.rotation_degrees += 90
	#	Gets the player group 
	player = get_tree().get_nodes_in_group("player")[0]
#	Increase imp count
	Global.curr_imp += 1
pass



func _process(delta: float) -> void:
#	moves to the player
	if is_instance_valid(player):
	
		var playerpos= player.global_position
		#
#		This makes the imp face the player
		$Sprite2D.look_at(playerpos)
		health_bar.value = health
		
		
		
		

pass

func _physics_process(delta: float) -> void:
	var direction = Vector3()
		
	if is_instance_valid(player):
		nav.target_position=player.global_position

	var curr_nav_position = global_position
	var next_nav_position = nav.get_next_path_position()
	var new_velocity = curr_nav_position.direction_to(next_nav_position) * speed
	 
	if nav.avoidance_enabled:
		nav.set_velocity(new_velocity)
		
	else: 
		_on_navigation_agent_2d_velocity_computed(new_velocity)
	
pass

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	
	
	velocity = safe_velocity
	move_and_slide()
	pass # Replace with function body.

func _on_hitbox_area_entered(area: Area2D) -> void:
	
#	This allows for the imp to be damaged by the player
	if area. is_in_group("bullet"):
		health-= Global.player_stats["damage"]
		area.queue_free()
		
		
		if health <= 0:
			Global.curr_imp -= 1
			queue_free()
			
			Global.points += 2
			print (Global.points)
	pass # Replace with function body.

	
