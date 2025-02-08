extends Node2D

const LERP_SPEED = 10



@onready var player = get_node("Player")
@onready var camera: Camera2D = get_node("Camera2D")
@onready var animals = get_node("Animals").get_children()

@onready var ground_layer: TileMapLayer = get_node("GroundLayer")
@onready var surface_layer: TileMapLayer = get_node("SurfaceLayer")
@onready var object_layer: TileMapLayer = get_node("ObjectLayer")
@onready var foliage_layer: TileMapLayer = get_node("FoliageLayer")

var layers_in_priority = []

func _physics_process(delta: float) -> void:
	camera.global_position = lerp(camera.global_position, player.global_position, delta * LERP_SPEED)


func _process(delta):
	var foliage_cell: Vector2i = foliage_layer.local_to_map(player.position)

	if foliage_cell in foliage_layer.get_used_cells():
		player.z_index = 0
	else:
		player.z_index = player.global_position.y

	
func _input(event: InputEvent):
	if event.is_action_pressed("execute"):
		
		
		var affected_cell: Vector2i = ground_layer.local_to_map(player.position) + player.last_velocity
		
		var affected_cell_atlas: Vector2i = ground_layer.get_cell_atlas_coords(affected_cell)
		#print(affected_cell_atlas)
		var alt_tile = ground_layer.get_cell_alternative_tile(affected_cell)
		ground_layer.set_cell(affected_cell, TileCoords.LUMINO_SOURCE, affected_cell_atlas, 1)
		print(affected_cell_atlas)
		#var revived_cell_atlas = affected_cell_atlas + Vector2i.RIGHT
		#
		#if not ground_layer.get_cell_tile_data(affected_cell).get_custom_data("revived"):
			#ground_layer.set_cell(affected_cell, TileCoords.LUMINO_SOURCE, revived_cell_atlas)
		#
		_make_pigs_fly()


func _make_pigs_fly():
	for animal in animals:
		animal.evolve()
