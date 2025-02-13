extends Interactable


const FLYING_PIG: SpriteFrames = preload("res://assets/spriteframes/flying_pig.tres")

@onready var animated_sprite = get_node("AnimatedSprite2D")

func _ready():
	z_index = global_position.y
	await get_tree().create_timer(randf()).timeout
	animated_sprite.play()
	

func interact(_player):
	get_node("Hearts").emitting = true
	animated_sprite.speed_scale *= 4
	await get_tree().create_timer(0.5).timeout
	animated_sprite.speed_scale = 1
	

func evolve():
	get_node("GPUParticles2D").emitting = true
	await get_tree().create_timer(0.5).timeout
	animated_sprite.sprite_frames = FLYING_PIG
	animated_sprite.play()
