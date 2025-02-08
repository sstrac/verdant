extends CharacterBody2D


const SPEED = 100


@onready var animation_tree = get_node("AnimationTree")

var last_velocity: Vector2i = Vector2.ZERO


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction.sign() * SPEED
	
	var norm_velocity = velocity.normalized()
	last_velocity = norm_velocity if velocity else last_velocity
	
	animation_tree.set('parameters/walk/blend_position', last_velocity)
	animation_tree.set('parameters/still/blend_position', last_velocity)
	animation_tree.set('parameters/conditions/walk', velocity)
	animation_tree.set('parameters/conditions/still', !velocity)
	

	move_and_slide()
