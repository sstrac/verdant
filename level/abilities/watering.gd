extends Ability


class_name Watering


func _init():
	texture = preload("res://assets/textures/infrastructure/watering_can.png")
	
	
func perform(player) -> bool:
	if player.closest_interactable:
		if player.closest_interactable.waterable:
			player.audio_stream_player.stream = Sounds.WATER_SOUND
			player.audio_stream_player.play()
			player.closest_interactable.interact(player)
			return true
		elif player.closest_interactable.destroyable:
			player.audio_stream_player.stream = Sounds.ZAP_SOUND
			player.audio_stream_player.play()
			player.health -= 1
			
	return false
