extends Camera2D

const SCROLL_SPEED : float = 500.0  # must match the bird's SCROLL_SPEED

func _physics_process(delta: float) -> void:
	position.x += SCROLL_SPEED * delta
