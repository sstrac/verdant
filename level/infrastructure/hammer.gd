extends Interactable


func interact(player):
	player.available_abilities.append(Hammer.new())
	queue_free()
