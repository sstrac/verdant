extends Interactable


func interact(player):
	player.available_abilities.append(Watering.new())
	queue_free()
