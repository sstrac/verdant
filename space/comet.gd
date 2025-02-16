extends GPUParticles2D

const SPEED = 15

func _physics_process(delta: float) -> void:
	var direction = -Vector2(process_material.direction.x, process_material.direction.y)
	global_position += delta * direction * SPEED
