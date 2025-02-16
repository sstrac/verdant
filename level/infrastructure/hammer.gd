extends Interactable


func interact(player):
	player.available_abilities.append(Abilities.HAMMER)
	player.signal_first_item_acquired()
	queue_free()
