extends CharacterBody2D

@onready var smp: Node = $StateMachinePlayer

@export var speed = 300.0

@export var health = 100

@export var bullet= preload("res://Bullet.tscn")

var corrupt_score = Global.player_stats["corruption_base"]

var mouse_pos = Vector2.ZERO

var curr_state = "idle"

var decaying = false

func _ready() -> void:
	Global.player_stats["health"] = health
	Global.player = self
pass


func get_input(): 
	var input_direction = Input.get_vector("left", "right", "up","down")
	velocity = input_direction * speed
pass


func _physics_process(delta):
	print(Global.player_stats["health"])
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
	pass
	
	

	
	
	
#Allows player to shoot 
func shoot():
	if Input.is_action_just_pressed("shoot"):
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
	pass
	
	
#	Creates the mouse position for the bullet
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		
		mouse_pos= event.position
		
		shoot()

func _on_corruption_timer_timeout() -> void:
	if corrupt_score <= 100:
		corrupt_score += 3
		
	else: corrupt_score >= 100
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

func damaged():
	$Invulnerable.start()
	

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


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		Global.player_stats["health"] -= body.damage
		smp.set_trigger("damaged")
	pass # Replace with function body.
