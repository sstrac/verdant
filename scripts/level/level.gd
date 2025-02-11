extends Node2D

const LERP_SPEED = 10
const VECTOR_16 = Vector2i(16, 16)


@onready var player = get_node("Player")
@onready var camera: Camera2D = get_node("Camera2D")
@onready var animals = get_node("Animals").get_children()

@onready var ground_layer: TileMapLayer = get_node("GroundLayer")
@onready var surface_layer: TileMapLayer = get_node("SurfaceLayer")
@onready var foliage_layer: TileMapLayer = get_node("FoliageLayer")


func _physics_process(delta: float) -> void:
	camera.global_position = lerp(camera.global_position, player.global_position, delta * LERP_SPEED)


func _process(delta):
	var foliage_cell: Vector2i = foliage_layer.local_to_map(player.position)

	if foliage_cell in foliage_layer.get_used_cells():
		player.z_index = 0
	else:
		player.z_index = player.global_position.y



func _perform_action():
	if not player.closest_revivable.revived:
		player.closest_revivable.revive()
	

func _revive_tile():
	var direction: Vector2i = player.last_velocity.sign()
	var map_cell = ground_layer.local_to_map(player.position) + direction
	var atlas_cell = ground_layer.get_cell_atlas_coords(map_cell)
	var cell_data = ground_layer.get_cell_tile_data(map_cell)
	var dead
	if cell_data:
		dead = cell_data.get_custom_data('dead')
	
	if atlas_cell != -Vector2i.ONE:# and dead:
		ground_layer.set_cell(map_cell, TileCoords.LUMINO_SOURCE, atlas_cell + Vector2i.RIGHT)


func _input(event: InputEvent):
	if event.is_action_pressed("execute"):
		_perform_action()
		_make_pigs_fly()


func _make_pigs_fly():
	for animal in animals:
		animal.evolve()
