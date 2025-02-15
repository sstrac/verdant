extends Interactable


const UNEARTHED_TEXTURE = preload("res://assets/textures/infrastructure/watering_can_mini.png")

@onready var sprite = get_node("Sprite2D")

var buried = true

func interact(player):
	if not buried:
		player.available_abilities.append(Abilities.WATERING)
		queue_free()


func unbury():
	sprite.texture = UNEARTHED_TEXTURE
	buried = false
