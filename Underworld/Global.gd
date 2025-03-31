extends Node


@export var scene: String
var main_scene = "Main"
var shop_scene = "shop"
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

#Player stats
var player = null
var player_active = true
var curr_imp = 0
var curr_floater = 0
var curr_sage = 0
var points = 0

var player_stats = {
	"damage": 2,
	"max_health": 100,
	"health": 100,
	"corruption_max":100,
	"corruption_base":0,
	"max_corruption":100,
	"lifesteal": 0,
	"fire_rate": .5,
	"speed":200,
}

var imp_stats = {
	"health" : 5,
	"max_health": 5,
}

var floater_states = {
	"health" : 10,
	"max_health": 10,
}



func _ready() -> void:
	var fade_in_first_scene_options = SceneManager.create_options(1, "fade")
	var first_scene_general_options = SceneManager.create_general_options(Color(0, 0, 0), 1, false)
	SceneManager.show_first_scene(fade_in_first_scene_options, first_scene_general_options)
	# code breaks if scene is not recognizable
	SceneManager.validate_scene(shop_scene)
	# code breaks if pattern is not recognizable
	SceneManager.validate_pattern(fade_out_pattern)
	SceneManager.validate_pattern(fade_in_pattern)

func _process(delta: float) -> void:
	if player_stats["health"] <= 0:
		SceneManager.change_scene(shop_scene, fade_out_options, fade_in_options, general_options)
		player_stats["health"] = 100
	


func instance_node(node, location , parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
