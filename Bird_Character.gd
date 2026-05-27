extends CharacterBody2D

# ── Tuning ──────────────────────────────────────────────────────────────────
const GRAVITY       : float = 1200.0
const FLAP_STRENGTH : float = -720.0
const MAX_FALL      : float =  700.0
const SCROLL_SPEED  : float =  500.0  # pixels/s forward speed — tweak this

# ── Internal ────────────────────────────────────────────────────────────────
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

var screen_top    : float = 0.0
var screen_bottom : float = 0.0

func _ready() -> void:
	anim.flip_h = true
	anim.play("fly")

	var viewport_height : float = get_viewport().get_visible_rect().size.y
	var camera : Camera2D = get_viewport().get_camera_2d()

	if camera:
		var half_height : float = (viewport_height / camera.zoom.y) / 2.0
		screen_top    = camera.global_position.y - half_height
		screen_bottom = camera.global_position.y + half_height
	else:
		screen_top    = 0.0
		screen_bottom = viewport_height

	position = Vector2(200, (screen_top + screen_bottom) / 2.0)

func _physics_process(delta: float) -> void:
	# ── Forward movement ────────────────────────────────────────────────────
	velocity.x = SCROLL_SPEED

	# ── Gravity ─────────────────────────────────────────────────────────────
	velocity.y += GRAVITY * delta
	velocity.y  = minf(velocity.y, MAX_FALL)

	if Input.is_action_just_pressed("ui_accept"):
		flap()

	move_and_slide()

	# ── Vertical bounds ─────────────────────────────────────────────────────
	if position.y < screen_top:
		position.y = screen_top
		velocity.y = 0.0
	elif position.y > screen_bottom:
		position.y = screen_bottom
		velocity.y = 0.0

func flap() -> void:
	velocity.y = FLAP_STRENGTH
