extends CharacterBody2D


@export var speed = 300.0

@export var health = 100

@export var bullet= preload("res://Bullet.tscn")

var corrupt_score = 0

var mouse_pos = Vector2.ZERO

var curr_state = "idle"

func _ready() -> void:
	Global.player = self

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
	
	
func death():
	if health >=0:
		queue_free()
pass
