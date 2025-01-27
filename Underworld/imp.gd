extends CharacterBody2D


@export var speed= 100
@export var knockback: float = 300

#Referance to player
var player



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



	
