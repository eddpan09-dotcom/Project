extends CharacterBody2D

# ── Tuning ──────────────────────────────────────────────────────────────────
const GRAVITY       : float = 1800.0  # pixels/s² pulling the crow down
const FLAP_STRENGTH : float = -520.0  # negative = upward (tweak to taste)
const MAX_FALL      : float =  600.0  # terminal velocity cap

# ── Screen bounds (adjust to your viewport height) ──────────────────────────
const SCREEN_TOP    : float =   0.0
const SCREEN_BOTTOM : float = 600.0

# ── Internal ────────────────────────────────────────────────────────────────
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	# ✅ Flip crow to face RIGHT
	anim.flip_h = true

	# Change "fly" to your actual animation name
	anim.play("fly")

	# Start mid-screen
	position = Vector2(200, SCREEN_BOTTOM / 2)


func _physics_process(delta: float) -> void:
	# ── Gravity ─────────────────────────────────────────────────────────────
	velocity.y += GRAVITY * delta
	velocity.y  = minf(velocity.y, MAX_FALL)

	# ── Flap input (Space or Enter) ─────────────────────────────────────────
	if Input.is_action_just_pressed("ui_accept"):
		flap()

	# ── Move ────────────────────────────────────────────────────────────────
	move_and_slide()

	# ── Keep crow on screen ─────────────────────────────────────────────────
	if position.y < SCREEN_TOP:
		position.y = SCREEN_TOP
		velocity.y = 0.0
	elif position.y > SCREEN_BOTTOM:
		position.y = SCREEN_BOTTOM
		velocity.y = 0.0


func flap() -> void:
	velocity.y = FLAP_STRENGTH
