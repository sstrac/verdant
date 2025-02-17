extends Interactable


const REVIVED_TEXTURE = preload("res://assets/textures/infrastructure/generator_revived.png")

@onready var sprite = get_node("Sprite2D")
@onready var animation_player = get_node("AnimationPlayer")
@onready var audio_stream_player = get_node("AudioStreamPlayer2D")
@onready var smoke = get_node("Smoke")


var broken = false:
	set(b):
		var broken_before = broken
		broken = b
		if not broken_before and broken:
			has_broken.emit()
		
var is_revived: bool = false

signal revived
signal has_broken
	

func _ready():
	z_index = position.y


func interact(player):
	if not broken and player.current_ability == Abilities.HAMMER:
		player.audio_stream_player.stream = Sounds.HAMMER_SOUND
		player.audio_stream_player.play()
		animation_player.play('break')
		audio_stream_player.stop()
		smoke.visible = false
		broken = true
		
	elif broken and player.current_ability == Abilities.WATERING:
		player.audio_stream_player.stream = Sounds.WATER_SOUND
		player.audio_stream_player.play()
		is_revived = true
		revived.emit()
		sprite.texture = REVIVED_TEXTURE
			
	elif not broken and player.current_ability == Abilities.WATERING:
		player.audio_stream_player.stream = Sounds.ZAP_SOUND
		player.audio_stream_player.play()
		player.health -= 1
