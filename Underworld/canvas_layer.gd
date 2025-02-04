extends CanvasLayer


@onready var corruption: ProgressBar = $Corruption
@onready var health: ProgressBar = $Health



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.player_active:
		
		health.value = lerp(float(health.value), float (Global.player.health), 0.093)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
