extends CanvasLayer


@onready var points: Label = $Points
@onready var health: Label = $Health


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	points.text = "Points:" + str(Global.points)
	health.text = "Health: " + str( Global.player_stats["health"]) 
	pass
