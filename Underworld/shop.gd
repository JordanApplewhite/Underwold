extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.player_active: 
		visible=false
		
	else: Global.player_active = false
	visible = true



	pass

func _on_damage_up_1_pressed() -> void:
	Global.player_stats["damage"] += 2
	$"Damage Up 1".text= "Damage Up 1 (Bought)"
	$"Damage Up 1".disabled
	pass # Replace with function body.


func _on_damage_up_2_pressed() -> void:
	Global.player_stats["damage"] += 2
	$"Damage Up 2".text = "Deamge Up 2 (Bought)"
	$"Damage Up 2".disabled
	pass # Replace with function body.


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
