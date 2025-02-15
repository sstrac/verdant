extends Interactable

const BROKEN_TEXTURE = preload("res://assets/textures/infrastructure/power_line_broken.png")

@onready var connector = get_node("Connector")
@onready var sprite = get_node("Sprite2D")


@export var broken: bool = false:
	set(b):
		if not broken and b:
			has_broken.emit()
		broken = b

signal has_broken


func _ready():
	z_index = global_position.y
	

func interact(player):
	if not broken:
		broken = true
		sprite.texture = BROKEN_TEXTURE
