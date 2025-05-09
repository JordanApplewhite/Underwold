extends CharacterBody2D

@onready var smp: Node = $StateMachinePlayer

var speed = Global.player_stats["speed"]

var health = Global.player_stats["health"]

var max_health = Global.player_stats["max_health"]

@export var bullet= preload("res://Bullet.tscn")

var corrupt_score = Global.player_stats["corruption_base"]

var mouse_pos = Vector2.ZERO

var curr_state = "idle"

var decaying = false
var can_fire = true

func _ready() -> void:
	Global.player_stats["health"] = health
	Global.player = self
pass


func get_input(): 
	var input_direction = Input.get_vector("left", "right", "up","down")
	velocity = input_direction * speed
pass


func _physics_process(delta):
	
	get_input()
	move_and_slide()
	
	#shoot()
pass

func _process(delta: float) -> void:
	match curr_state:
		"death":
			death()
		
	decay()
	slow()
	$"Fire rate".wait_time = Global.player_stats["fire_rate"]
	health_limit()
	pass
	

	
	
	
#Allows player to shoot 
func shoot():
	if Input.is_action_just_pressed("shoot") and can_fire:
		var new_bullet = bullet.instantiate()
		var target_vec = mouse_pos-global_position
		
		target_vec = target_vec.normalized()
		
		new_bullet.direction = target_vec
		new_bullet.global_position = global_position
		new_bullet.look_at(mouse_pos)
		new_bullet.rotation_degrees+=90
		get_tree().get_root().add_child(new_bullet)
		target_vec= target_vec.normalized()
		$Pew.play()
		can_fire = false
		$"Fire rate".start()
	pass
	
	
#	Creates the mouse position for the bullet
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		
		mouse_pos= event.position
		
		shoot()

func _on_corruption_timer_timeout() -> void:
	if corrupt_score <= Global.player_stats["max_corruption"]:
		corrupt_score += 3
		
		
	else: corrupt_score >= Global.player_stats["max_corruption"]
	corrupt_score += 0
	pass # Replace with function body.
	
func slow():
	if corrupt_score >= 50:
		speed = 225
	pass

func decay():
	if corrupt_score >= 100:             
		#$"Decay timer".start()
		decaying=true
		
	else: 
		decaying= false
pass

	
func death():
	if health >=0:
		queue_free()
		Global.player_active = false
pass

	
	
	

func _on_decay_timer_timeout() -> void:
	if decaying: 
		health -= 2
	
	pass # Replace with function body.

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy bullet"):
		Global.player_stats["health"] -= area.damage
		area.queue_free()
		smp.set_trigger("damaged")
	
	pass # Replace with function body.


func _on_state_machine_player_updated(state: Variant, delta: Variant) -> void:
	curr_state = state
	pass # Replace with function body.


func _on_fire_rate_timeout() -> void:
	can_fire = true
	pass # Replace with function body.

func health_limit():
	if Global.player_stats["health"] >= Global.player_stats["max_health"]:
		Global.player_stats["lifesteal"] = 0
		Global.player_stats["health"] = Global.player_stats["max_health"]
	elif Global.player_stats["health"] < Global.player_stats["max_health"]:
		Global.player_stats["lifesteal"] = Global.player_stats["lifesteal_max"]
		
pass
