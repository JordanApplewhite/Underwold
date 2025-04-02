extends CharacterBody2D

@export var health = 10
@export var speed = 50
var accel = 7
var can_damage = true
@export var knockback: float = 300
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var healthbar: ProgressBar = $healthbar


#Referance to player
var player = preload("res://Player/player.tscn")
var bullet = preload("res://Enemies/floater_bullet.tscn")



func _ready() -> void:
#	This rotates the imp fixes the imps rotation to face the player
	

	#	Gets the player group 
	player = get_tree().get_nodes_in_group("player")[0]
#	Increase imp count
	Global.curr_floater += 1
pass



func _process(delta: float) -> void:
	
#	moves to the player
	if player:
	
		var playerpos= player.global_position
		
		healthbar.value = health


pass

func _physics_process(delta: float) -> void:
	var direction = Vector3()
		
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

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		health-=Global.player_stats["damage"]
		area.queue_free()
		
		
		if health <= 0:
			Global.curr_floater -= 1
			queue_free()
			Global.points += 5
			
			Global.player_stats["health"] += Global.player_stats["lifesteal"]
			
	
	pass # Replace with function body.


func shoot():
	if player:
		var new_bullet = bullet.instantiate()
		var target_vec = player.global_position-global_position
		
		target_vec = target_vec.normalized()
		
		new_bullet.direction = target_vec
		new_bullet.global_position = global_position
		new_bullet.look_at(player.global_position)
		new_bullet.rotation_degrees+=0
		get_tree().get_root().add_child(new_bullet)
		target_vec= target_vec.normalized()

func _on_fire_rate_timeout() -> void:
	shoot()
	pass # Replace with function body.

func _on_damage_area_area_entered(area: Area2D) -> void:
	if area. is_in_group("player") and can_damage:
		can_damage = false
		
	pass # Replace with function body.

func _on_damage_rate_timeout() -> void:
	can_damage = true
	pass # Replace with function body.
	pass # Replace with function body.
