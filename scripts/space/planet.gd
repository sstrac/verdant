extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var sprite: Texture2D
@export var scene: PackedScene


func _ready() -> void:
	if sprite:
		sprite_2d.texture = sprite


func _on_interaction_zone_body_entered(body: Node2D) -> void:
	body.add_prompt_enter_planet(scene)


func _on_interaction_zone_body_exited(body: Node2D) -> void:
	body.remove_prompt_enter_planet()
