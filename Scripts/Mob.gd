extends CharacterBody2D

const SPEED = 40
@export var health : float = 30.0
@export var attack_damage : float = 2.0
@onready var player := $"../Hitman"
@onready var timer = $AttackCooldownTimer

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	look_at(player.global_position)
	velocity = direction * SPEED
	move_and_slide()
	attack()
	
func attack():
	if timer.is_stopped():
		# Check what is colliding with the mob, if it's the player, attack
		for index in get_slide_collision_count():
			var collision := get_slide_collision(index)
			var body := collision.get_collider()
			if body.has_method("take_damage"):
				timer.start()
				player.take_damage(attack_damage)

func take_damage(damage: float) -> void:
	health -= damage
	if health <= 0:
		queue_free()
	# DEBUG
	#print("health: ", health)
	#print("ouchie, damage received: ", damage)
