extends Node2D

const LERP_SPEED = 10
const VECTOR_16 = Vector2i(16, 16)


@onready var player = get_node("Player")
@onready var camera: Camera2D = get_node("Camera2D")
@onready var animals = get_node("Animals").get_children()

@onready var ground_layer: TileMapLayer = get_node("GroundLayer")
@onready var surface_layer: TileMapLayer = get_node("SurfaceLayer")
@onready var ui = get_node("CanvasLayer/UI")

	
func _physics_process(delta: float) -> void:
	camera.global_position = lerp(camera.global_position, player.global_position, delta * LERP_SPEED)


func _process(delta):
	_set_z_index_for_surface_layer()


func _revive_tile():
	var direction: Vector2i = player.last_velocity.sign()
	var map_cell = ground_layer.local_to_map(player.position) + direction
	var atlas_cell = ground_layer.get_cell_atlas_coords(map_cell)
	var cell_data = ground_layer.get_cell_tile_data(map_cell)
	var dead
	if cell_data:
		dead = cell_data.get_custom_data('dead')
	
	if atlas_cell != -Vector2i.ONE:
		ground_layer.set_cell(map_cell, TileCoords.LUMINO_SOURCE, atlas_cell + Vector2i.RIGHT)


func _input(event: InputEvent):
	if event.is_action_pressed("execute"):
		player.current_ability.perform(player)
		_make_pigs_fly()
	elif event.is_action_pressed("tab"):
		player.switch_abilities()
		ui.change_ability(player.current_ability)

func _set_z_index_for_surface_layer():
	var surface_cell: Vector2i = surface_layer.local_to_map(player.position)

	if surface_cell in surface_layer.get_used_cells():
		player.z_index = 0
	else:
		player.z_index = player.global_position.y


func _make_pigs_fly():
	for animal in animals:
		animal.evolve()
