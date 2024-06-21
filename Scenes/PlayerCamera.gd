extends Camera2D

@export var random_strength : float = 5.0
@export var shake_fade : float = 0.0
@export var camera_shake_duration : float = 0.0

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

func _ready():
	pass
	
func apply_shake(duration: float) -> void:
	shake_strength = random_strength
	camera_shake_duration = duration

func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		offset = random_offset()
		camera_shake_duration -= delta
		if camera_shake_duration <= 0:
			shake_strength = 0

func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
