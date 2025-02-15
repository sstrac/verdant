extends Interactable


func interact(player):
	player.available_abilities.append(Abilities.HAMMER)
	queue_free()
