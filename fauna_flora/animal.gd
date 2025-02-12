extends AnimatedSprite2D


const FLYING_PIG: SpriteFrames = preload("res://assets/spriteframes/flying_pig.tres")


func _ready():
	z_index = global_position.y
	await get_tree().create_timer(randf()).timeout
	play()
	
	
func evolve():
	get_node("GPUParticles2D").emitting = true
	await get_tree().create_timer(0.5).timeout
	sprite_frames = FLYING_PIG
	play()
