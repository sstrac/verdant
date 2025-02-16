extends Ability


class_name Hammer


func _init():
	texture = preload("res://assets/textures/infrastructure/hammer.png")
	
	
func perform(player) -> bool:
	if player.closest_interactable:
		if player.closest_interactable.destroyable:
			player.closest_interactable.interact(player)
			return true
	
	return false
