extends CharacterBody2D

@export var health = 5
@export var speed= 100
@export var knockback: float = 300

#Referance to player
var player = preload("res://Player/player.tscn")



func _ready() -> void:
#	Gets the player group 
	player = get_tree().get_nodes_in_group("player")[0]
pass



func _process(delta: float) -> void:
#	moves to the player
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity= direction*speed
		move_and_slide()
	
pass



func _on_hitbox_area_entered(area: Area2D) -> void:
	
	if area. is_in_group("bullet"):
		health-=2
		area.queue_free()
		print(health)
		
		if health <= 0:
			queue_free()
		
	pass # Replace with function body.

	
