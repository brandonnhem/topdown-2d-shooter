extends CharacterBody2D

@export var maxHealth = 30
@onready var currentHealth : int = maxHealth
var speed = 400 # speed in pixels/sec

var weapons = [] # init empty weapons
var sprite_variations = { # init sprite variations
	"gun" : "res://Assets/kenney_top-down-shooter/PNG/Hitman 1/hitman1_gun.png",
	"hold" : "res://Assets/kenney_top-down-shooter/PNG/Hitman 1/hitman1_hold.png",
	"machine" : "res://Assets/kenney_top-down-shooter/PNG/Hitman 1/hitman1_machine.png",
	"reload" : "res://Assets/kenney_top-down-shooter/PNG/Hitman 1/hitman1_reload.png",
	"silencer" : "res://Assets/kenney_top-down-shooter/PNG/Hitman 1/hitman1_silencer.png"
}

var cursor_variations = {
	"default" : "res://Assets/Kenney_Crosshairs/PNG/Outline/crosshair001.png",
	"gun" : "res://Assets/Kenney_Crosshairs/PNG/Outline/crosshair007.png",
	"machine" : "res://Assets/Kenney_Crosshairs/PNG/Outline/crosshair018.png",
	"silencer" : "res://Assets/Kenney_Crosshairs/PNG/Outline/crosshair046.png"
}
 
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()

func add_weapon(weapon_type: String) -> void:
	weapons.append(weapon_type)
	print(weapons)
	match weapon_type:
		"gun":
			_change_sprite(weapon_type)
			_change_cursor_type(weapon_type)
			
func _change_sprite(weapon_type: String) -> void:
	var texture = load(sprite_variations[weapon_type])
	$Sprite2D.texture = texture

func _change_cursor_type(cursor_type: String) -> void:
	var cursor = load(cursor_variations[cursor_type])
	Input.set_custom_mouse_cursor(cursor)

func get_input() -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	look_at(get_global_mouse_position())
	velocity = direction * speed
	
	if Input.is_action_just_pressed("shoot"):
		if "gun" in weapons:
			_shoot()
	if Input.is_action_just_pressed("reload"):
		_reload()
	#elif event is InputEventKey:
		#if event.button_index == "reload" and event.pressed:
			#_reload()
	
func _shoot() -> void:
	var bullet = load("res://Scenes/Bullet.tscn")
	var new_bullet = bullet.instantiate()
	get_tree().root.add_child(new_bullet)
	new_bullet.transform = $Muzzle.global_transform
	
# TODO: Reload the amount of bullets stored within the gun.
#		Might need to create a class object to store the different variables of the gun
func _reload() -> void:
	print("I'm reloading here!")
	
func update_health() -> void:
	$HealthBar.value = currentHealth
	print("Player's health: ", currentHealth)
	
func take_damage(damage: float) -> void:
	$PlayerCamera.apply_shake(0.1)
	currentHealth -= damage
	update_health()
