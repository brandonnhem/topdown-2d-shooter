extends CharacterBody2D
@export var Bullet : PackedScene

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
	var direction = Input.get_vector("left", "right", "up", "down")
	look_at(get_global_mouse_position())
	velocity = direction * speed
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

func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_shoot()
	
func _shoot() -> void:
	print("PEW")
