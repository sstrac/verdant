extends CharacterBody2D


const ORTHOGONAL_SPEED = 100
const DIAGONAL_SPEED = 75
const CUTSCENE_SPEED = 50

@onready var animation_tree = get_node("AnimationTree")
@onready var audio_stream_player: AudioStreamPlayer = get_node("AudioStreamPlayer")

var intro_cutscene = true
var outro_cutscene = false
var last_velocity = Vector2.DOWN
var available_abilities = []
var current_ability: Ability
var closest_interactable: Interactable

var health = 10:
	set(h):
		health = h
		health_changed.emit()
		if health == 0:
			died.emit()

var pig_pet_count = 0:
	set(p):
		if p < 10:
			pig_pet_count = p
		elif not procrastinated:
			procrastinated = true
			procrastination.emit()
			

var procrastinated: bool = false
var time = 0
var game_has_finished = false

signal health_changed
signal died
signal procrastination
signal first_item_acquired
signal game_finished


func _ready():
	available_abilities.append(Abilities.HAND)
	current_ability = available_abilities[0]


func switch_abilities():
	var current_i = available_abilities.find(current_ability)
	
	if current_i + 1 == available_abilities.size():
		current_ability = available_abilities[0]
	else:
		current_ability = available_abilities[current_i + 1]


func _physics_process(delta: float) -> void:
	if intro_cutscene:
		if global_position.x >= 400:
			velocity = Vector2.DOWN * CUTSCENE_SPEED
		else:
			time += delta
			velocity = (Vector2.RIGHT * CUTSCENE_SPEED) + (Vector2.UP * cos(time) * 10)
		
		if global_position.y >= 320:
			velocity = Vector2.ZERO
	elif outro_cutscene:
		time += delta
		velocity = (Vector2.LEFT * CUTSCENE_SPEED) + (Vector2.UP * cos(time) * 10)
		
		if global_position.x < -1100 and not game_has_finished:
			game_has_finished = true
			game_finished.emit()
	else:
		var direction = Input.get_vector("left", "right", "up", "down")
		var speed = ORTHOGONAL_SPEED
		
		if velocity.x != 0 and velocity.y != 0 : 
			speed = DIAGONAL_SPEED 
		velocity = direction.sign() * speed 
		
		last_velocity = velocity if velocity else last_velocity
		_animate()

	move_and_slide()
	
	
func _animate():
	animation_tree.set('parameters/walk/blend_position', last_velocity)
	animation_tree.set('parameters/still/blend_position', last_velocity)
	animation_tree.set('parameters/conditions/walk', velocity)
	animation_tree.set('parameters/conditions/still', !velocity)


func stop_physics_input():
	set_physics_process(false)
	velocity = Vector2i.ZERO
	_animate()


func start_physics_input():
	set_physics_process(true)
	

func disable_collision():
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(2, false)
	set_collision_mask_value(2, false)
	get_node("Area2D").set_collision_layer_value(1, false)
	get_node("Area2D").set_collision_layer_value(2, false)
	get_node("Area2D").set_collision_mask_value(1, false)
	get_node("Area2D").set_collision_mask_value(2, false)


func enable_collision():
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	set_collision_layer_value(2, true)
	set_collision_mask_value(2, true)
	get_node("Area2D").set_collision_layer_value(1, true)
	get_node("Area2D").set_collision_layer_value(2, true)
	get_node("Area2D").set_collision_mask_value(1, true)
	get_node("Area2D").set_collision_mask_value(2, true)
	
	
func signal_first_item_acquired():
	first_item_acquired.emit()


func _on_area_2d_area_entered(area: Area2D) -> void:
	var direction_to_area = global_position.direction_to(area.global_position)

	var coming_from_x_axis = abs(direction_to_area.x) >= abs(direction_to_area.y)
	var facing_x = direction_to_area.sign().x == velocity.sign().x
	var coming_from_y_axis = abs(direction_to_area.x) < abs(direction_to_area.y)
	var facing_y = direction_to_area.sign().y == velocity.sign().y

	var facing_area = (coming_from_x_axis and facing_x) or (coming_from_y_axis and facing_y)

	if facing_area:
		closest_interactable = area.get_parent()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if closest_interactable == area.get_parent():
		closest_interactable = null
