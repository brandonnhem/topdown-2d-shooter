extends Area2D

var speed = 1000

func _physics_proccess(delta: float) -> void:
	position += transform.x * speed * delta
	
