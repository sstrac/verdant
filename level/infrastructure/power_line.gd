extends Interactable

const BROKEN_TEXTURE = preload("res://assets/textures/infrastructure/power_line_broken.png")
const REVIVED_TEXTURE = preload("res://assets/textures/infrastructure/power_line_broken_revived.png")


@onready var connector = get_node("Connector")
@onready var sprite = get_node("Sprite2D")


@export var broken: bool = false:
	set(b):
		var broken_before = broken
		broken = b
		if not broken_before and broken:
			has_broken.emit()

var is_revived: bool = false

signal has_broken
signal revived


func _ready():
	z_index = global_position.y
	

func interact(player):
	if not broken and player.current_ability == Abilities.HAMMER:
		player.audio_stream_player.stream = Sounds.HAMMER_SOUND
		player.audio_stream_player.play()
		broken = true
		sprite.texture = BROKEN_TEXTURE
		
		
	elif broken and player.current_ability == Abilities.WATERING:
		player.audio_stream_player.stream = Sounds.WATER_SOUND
		is_revived = true
		revived.emit()
		sprite.texture = REVIVED_TEXTURE
		
	elif not broken and player.current_ability == Abilities.WATERING:
		player.audio_stream_player.stream = Sounds.ZAP_SOUND
		player.audio_stream_player.play()
		player.health -= 1
