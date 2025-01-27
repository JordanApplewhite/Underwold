extends CharacterBody2D

var speed = 1000
var pos:Vector2
var dir: float
var rota : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position=pos
	global_rotation=rota
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity=Vector2(speed,0).rotated(dir)
	move_and_slide()
	pass
