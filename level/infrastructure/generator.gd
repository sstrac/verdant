extends Interactable

@onready var animation_player = get_node("AnimationPlayer")
@onready var smoke = get_node("Smoke")


var broken = false

func _ready():
	z_index = position.y


func interact(_player):
	if not broken:
		animation_player.play('break')
		smoke.visible = false
		broken = true
