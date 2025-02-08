extends CharacterBody2D

const MAX_SPEED: int = 288
const ACCELERATION: int = 192
const FRICTION: int = 400

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var prompt: Sprite2D = $prompt
@export var SAUCER_UP: Texture2D
@export var SAUCER_DOWN: Texture2D
@export var SAUCER_LEFT: Texture2D
@export var SAUCER_RIGHT: Texture2D
var can_enter_planet: bool = false
var planet_to_enter: PackedScene = null


func add_prompt_enter_planet(scene: PackedScene) -> void:
	prompt.visible = true
	can_enter_planet = true
	planet_to_enter = scene


func remove_prompt_enter_planet() -> void:
	prompt.visible = false
	can_enter_planet = false


func enter_planet() -> void:
	null


func get_input():
	var direction := Input.get_vector("left", "right", "up", "down")
	return direction


func change_sprite(direction: Vector2):
	match direction:
		Vector2.UP:
			sprite_2d.texture = SAUCER_UP
		Vector2.DOWN:
			sprite_2d.texture = SAUCER_DOWN
		Vector2.LEFT:
			sprite_2d.texture = SAUCER_LEFT
		Vector2.RIGHT:
			sprite_2d.texture = SAUCER_RIGHT
			

func speed_manager(direction: Vector2, delta: float):
	if direction:
		direction = direction.normalized()
		velocity += direction * ACCELERATION * delta
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = velocity.limit_length(MAX_SPEED)
	
	velocity = velocity.round()
	
	return velocity


func _physics_process(delta: float) -> void:
	if can_enter_planet and Input.is_key_pressed(KEY_E):
		print(planet_to_enter)
		get_tree().change_scene_to_packed(planet_to_enter)
		pass
		
	var direction = get_input()
	change_sprite(direction)
	velocity = speed_manager(direction, delta)

	move_and_slide()
