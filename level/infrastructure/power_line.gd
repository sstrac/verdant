extends Interactable


@onready var connector = get_node("Connector")

var broken = false


func interact(player):
	if not broken:
		#animation_player.play('break')
		#smoke.visible = false
		broken = true
