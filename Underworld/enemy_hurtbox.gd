extends Area2D
@export var damage = 2
@export var attack_speed = 2
@export var continuous = true
var touching = false 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = 1/attack_speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		touching = true
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		touching = false
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	if touching:
		Global.player_stats ["health"] -= damage
	
	pass # Replace with function body.
