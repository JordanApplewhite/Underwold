extends Area2D

@export var speed = 400
var speed_mod = 1.0
var direction = Vector2.UP
var lifetime = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(lifetime).timeout
	queue_free()

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:


## Controls the speed of the projectile.  
	position += direction * speed * delta * speed_mod


	pass
