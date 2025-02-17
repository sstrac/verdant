extends Interactable


const PIG_LONG_SOUND = preload("res://assets/sfx/pig_long.wav")
const PIG_LOW_SOUND = preload("res://assets/sfx/pig_low.wav")
const FLYING_PIG: SpriteFrames = preload("res://assets/spriteframes/flying_pig.tres")

@onready var animated_sprite = get_node("AnimatedSprite2D")
@onready var audio_stream_player = get_node("AudioStreamPlayer2D")
@onready var area = get_node("Area2D")

@export var disable_regular_physics: bool = false
@export var space_animal: bool = false


var new_position
var original_position
var finished_digging = false

signal dug


func _ready():
	if space_animal:
		animated_sprite.sprite_frames = FLYING_PIG
		animated_sprite.play()
		z_index = 0
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		area.set_collision_layer_value(1, false)
		area.set_collision_mask_value(1, false) 
	else:
		z_index = global_position.y
		await get_tree().create_timer(randf()).timeout
		animated_sprite.play()
		original_position = global_position
		new_position = global_position
	

func _process(delta):
	if space_animal:
		global_position.x -= delta * 70
	else:
		if new_position and not disable_regular_physics:
			if not global_position.is_equal_approx(new_position):
				global_position += global_position.direction_to(new_position) * delta * 10
				

func interact(player):
	player.pig_pet_count += 1
	audio_stream_player.play()
	get_node("Hearts").emitting = true
	animated_sprite.speed_scale *= 4
	await get_tree().create_timer(0.5).timeout
	animated_sprite.speed_scale = 1
	

func evolve():
	get_node("GPUParticles2D").emitting = true
	await get_tree().create_timer(0.5).timeout
	animated_sprite.sprite_frames = FLYING_PIG
	animated_sprite.play()
	

func dig(pos):
	var spacing = global_position.direction_to(pos) * 10
	new_position = pos - spacing
	audio_stream_player.stream = PIG_LONG_SOUND
	audio_stream_player.play()
	await audio_stream_player.finished
	finished_digging = true
	dug.emit()
	audio_stream_player.stream = PIG_LOW_SOUND
	new_position = original_position
