extends Interactable

const BROKEN_TEXTURE = preload("res://assets/textures/infrastructure/power_line_broken.png")

@onready var connector = get_node("Connector")
@onready var sprite = get_node("Sprite2D")


@export var broken: bool = false:
	set(b):
		var broken_before = broken
		broken = b
		if not broken_before and broken:
			has_broken.emit()
		

signal has_broken


func _ready():
	z_index = global_position.y
	

func interact(player):
	if not broken:
		broken = true
		sprite.texture = BROKEN_TEXTURE
