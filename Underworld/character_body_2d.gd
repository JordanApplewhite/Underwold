extends CharacterBody2D


@export var health = 5
@export var speed = 100
var accel = 7
@onready var nav: NavigationAgent2D = $NavigationAgent2D
var touching = false
var player = preload("res://Player/player.tscn")
var imp = preload("res://Enemies/imp.tscn")
var floater = preload("res://Enemies/floater.tscn")



func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]
	Global.curr_sage += 1
pass

func _process(delta: float) -> void:
	
#	moves to the player
	if player:
	
		var playerpos= player.global_position

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

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		health-=Global.player_stats["damage"]
		area.queue_free()
		
		
		if health <= 0:
			Global.curr_sage -= 1
			queue_free()
			Global.points += 3
			Global.player_stats["health"] += Global.player_stats["lifesteal"]
			

	pass # Replace with function body.
