extends Interactable


func interact(player):
	player.available_abilities.append(Abilities.WATERING)
	queue_free()
