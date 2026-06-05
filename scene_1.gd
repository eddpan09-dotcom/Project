extends Node2D

@onready var label : Label = $Label
var score : int = 0

func _ready() -> void:
	pass  # keep whatever was here before

func _process(delta: float) -> void:
	pass  # keep whatever was here before

func add_score() -> void:
	score += 1
	label.text = str(score)
