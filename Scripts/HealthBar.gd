extends TextureProgressBar

@onready var player = $Hitman
@onready var HealthBar = $HealthBar

func _ready():
	update()

func update():
	value = player.currentHealth * 100 / player.maxHealth
