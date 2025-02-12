extends Interactable

@onready var animation_player = get_node("AnimationPlayer")

func _ready():
	z_index = position.y


func interact():
	animation_player.play('break')
