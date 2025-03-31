extends Area2D

@export var healing = 2
@export var heal_speed = 2
@export var continuous = true
var touching = false 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = 3
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		touching = true
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		touching = false
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	if touching:
		Global.imp_stats ["health"] += 2
		Global.floater_states["health"] +=2
	pass # Replace with function body.
