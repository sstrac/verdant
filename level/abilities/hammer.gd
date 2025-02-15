extends Ability


class_name Hammer

const HAMMER_SOUND = preload("res://assets/sfx/hammer.wav")

func _init():
	texture = preload("res://assets/textures/infrastructure/hammer.png")
	
	
func perform(player) -> bool:
	if player.closest_interactable:
		if player.closest_interactable.destroyable:
			player.audio_stream_player.stream = HAMMER_SOUND
			player.audio_stream_player.play()
			await player.get_tree().create_timer(0.6).timeout
			player.closest_interactable.interact(player)
			return true
	
	return false
