extends Area2D

var travelled_distance = 0
@export var damage : float

func _physics_process(delta: float) -> void:
	const RANGE = 1000
	const SPEED = 750
	var direction = Vector2.RIGHT.rotated(rotation)
	position += transform.x * SPEED * delta

	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
