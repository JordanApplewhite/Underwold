extends Node


var player = null
var player_active = true
var curr_imp = 0
var curr_floater = 0
var points = 0
var player_stats = {
	"damage": 2,
	"max_health": 100,
}

func instance_node(node, location , parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
