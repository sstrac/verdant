extends Ability


class_name Watering

const WATER_SOUND = preload("res://assets/sfx/water_randomizer.tres")


func _init():
	texture = preload("res://assets/textures/infrastructure/watering_can.png")
	
	
func perform(player) -> bool:
	if player.closest_interactable:
		if player.closest_interactable.waterable:
			player.audio_stream_player.stream = WATER_SOUND
			player.audio_stream_player.play()
			player.closest_interactable.interact(player)
			return true
		
	return false
