extends Interactable


@onready var connector = get_node("Connector")

@export var broken: bool = false

signal has_broken

func _ready():
	z_index = global_position.y
	

func interact(player):
	if not broken:
		broken = true
		has_broken.emit()
		#animation_player.play('break')
		#smoke.visible = false
