extends CharacterBody2D


const ORTHOGONAL_SPEED = 100
const DIAGONAL_SPEED = 75

@onready var animation_tree = get_node("AnimationTree")

var last_velocity: Vector2i = Vector2.ZERO


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	var speed = ORTHOGONAL_SPEED
	
	if velocity.x != 0 and velocity.y != 0 : 
		speed = DIAGONAL_SPEED 
	velocity = direction.sign() * speed 
	
	last_velocity = velocity if velocity else last_velocity

	
	animation_tree.set('parameters/walk/blend_position', last_velocity)
	animation_tree.set('parameters/still/blend_position', last_velocity)
	animation_tree.set('parameters/conditions/walk', velocity)
	animation_tree.set('parameters/conditions/still', !velocity)
	

	move_and_slide()
