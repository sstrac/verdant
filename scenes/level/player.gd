extends CharacterBody2D


const ORTHOGONAL_SPEED = 100
const DIAGONAL_SPEED = 75

@onready var animation_tree = get_node("AnimationTree")

var last_velocity = Vector2.ZERO
var closest_revivable: Revivable


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


func _on_area_2d_area_entered(area: Area2D) -> void:
	var direction_to_area = global_position.direction_to(area.global_position)
	
	# We are more LEFT/RIGHT than UP/DOWN
	var facing_area = (abs(direction_to_area.x) >= abs(direction_to_area.y) and direction_to_area.sign().x == velocity.sign().x) \
	# We are more UP/DOWN than LEFT/RIGHT
		or abs(direction_to_area.x) < abs(direction_to_area.y) and direction_to_area.sign().y == velocity.sign().y

	if facing_area:
		closest_revivable = area.get_parent()
