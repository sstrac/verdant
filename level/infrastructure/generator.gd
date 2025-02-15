extends Interactable

@onready var animation_player = get_node("AnimationPlayer")
@onready var audio_stream_player = get_node("AudioStreamPlayer2D")
@onready var smoke = get_node("Smoke")


var broken = false:
	set(b):
		var broken_before = broken
		broken = b
		if not broken_before and broken:
			has_broken.emit()
		

signal has_broken
	

func _ready():
	z_index = position.y


func interact(_player):
	if not broken:
		animation_player.play('break')
		audio_stream_player.stop()
		smoke.visible = false
		broken = true
