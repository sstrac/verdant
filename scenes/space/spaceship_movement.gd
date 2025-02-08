extends RigidBody2D


var thrust = Vector2(0, -50)
var torque = 200
var damping = 0.97
var can_enter_planet = false
@onready var prompt: Sprite2D = $"prompt"



func add_prompt_enter_planet(scene: PackedScene) -> void:
	prompt.visible = true
	can_enter_planet = true


func remove_prompt_enter_planet() -> void:
	prompt.visible = false
	can_enter_planet = false


func enter_planet() -> void:
	null


func _integrate_forces(state):
	if Input.is_action_pressed("ui_up"):
		state.apply_force(thrust.rotated(rotation))
	else:
		linear_velocity *= damping
	var rotation_direction = 0
	if Input.is_action_pressed("ui_right"):
		rotation_direction += 1
	if Input.is_action_pressed("ui_left"):
		rotation_direction -= 1
	state.apply_torque(rotation_direction * torque)
