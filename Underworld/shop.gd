extends CanvasLayer

var main_scene = "Main"

@export var scene: String
@export var fade_out_speed: float = 1.0
@export var fade_in_speed: float = 1.0
@export var fade_out_pattern: String = "fade"
@export var fade_in_pattern: String = "fade"
@export var fade_out_smoothness = 0.1 # (float, 0, 1)
@export var fade_in_smoothness = 0.1 # (float, 0, 1)
@export var fade_out_inverted: bool = false
@export var fade_in_inverted: bool = false
@export var color: Color = Color(0, 0, 0)
@export var timeout: float = 0.0
@export var clickable: bool = false
@export var add_to_back: bool = true

@onready var fade_out_options = SceneManager.create_options(fade_out_speed, fade_out_pattern, fade_out_smoothness, fade_out_inverted)
@onready var fade_in_options = SceneManager.create_options(fade_in_speed, fade_in_pattern, fade_in_smoothness, fade_in_inverted)
@onready var general_options = SceneManager.create_general_options(color, timeout, clickable, add_to_back)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fade_in_first_scene_options = SceneManager.create_options(1, "fade")
	var first_scene_general_options = SceneManager.create_general_options(Color(0, 0, 0), 1, false)
	SceneManager.show_first_scene(fade_in_first_scene_options, first_scene_general_options)
	# code breaks if scene is not recognizable
	SceneManager.validate_scene(scene)
	# code breaks if pattern is not recognizable
	SceneManager.validate_pattern(fade_out_pattern)
	SceneManager.validate_pattern(fade_in_pattern)
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
	SceneManager.change_scene(main_scene, fade_out_options, fade_in_options, general_options)
	Global.player_stats["health"] = Global.player_stats["max_health"]
	pass # Replace with function body.


func _on_health_up_1_pressed() -> void:
	Global.player_stats["max_health"] +=25
	$"Health Up 1".text = "Health Up 1 (Bought)"
	$"Health Up 1".disabled
	pass # Replace with function body.

func _on_health_up_2_pressed() -> void:
	Global.player_stats["max_health"] += 25
	$"Health Up 2".text = "Health Up 2 (Bought)"
	$"Health Up 2".disabled
	pass # Replace with function body.


func _on_lifesteal_1_pressed() -> void:
	Global.player_stats["lifesteal"] += 2
	Global.player_stats["lifesteal_max"] += 2
	$"Lifesteal 1".text = "Health on kill 1 (Bought)"
	$"Lifesteal 1".disabled
	pass # Replace with function body.


func _on_lifesteal_2_pressed() -> void:
	Global.player_stats["lifesteal"] += 2
	Global.player_stats["lifesteal_max"] += 2
	$"Lifesteal 2".text = "Health on kill 2 (Bought)"
	$"Lifesteal 2".disabled
	pass # Replace with function body.


func _on_corruption_resistance_1_pressed() -> void:
	Global.player_stats["corruption_max"] += 2
	$"Corruption Resistance 1".text = "Corruption Resistance 1 (Bought)"
	$"Corruption Resistance 1".disabled
	pass # Replace with function body.


func _on_corruption_resistance_2_pressed() -> void:
	Global.player_stats["corruption_max"] += 4
	$"Corruption Resistance 2".text = "Corruption Resistance 2 (Bought)"
	$"Corruption Resistance 2".disabled
	pass # Replace with function body.
