extends CharacterBody2D


@export var speed = 300.0

@export var health = 100


@export var bullet_path = preload("res://Bullet.tscn")

var corrupt_score = 0

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



func _on_corruption_timer_timeout() -> void:
	if corrupt_score <= 100:
		corrupt_score += 3
		print(corrupt_score)
	else: corrupt_score >= 100
	corrupt_score += 0

	pass # Replace with function body.
	
	
func death():
	if health >=0:
		queue_free()
pass
