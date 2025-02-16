extends Node2D


const LERP_SPEED = 10
const VECTOR_16 = Vector2i(16, 16)
const DIALOGUE_BOX = preload("res://dialogue/dialogue_box.tscn")
const PIG_FOLLOW_FIRST_CHECKPOINT = 735
const PIG_FOLLOW_SECOND_CHECKPOINT = 1044


@onready var player = get_node("Player")
@onready var ship = get_node("Player/Ship")
@onready var camera: Camera2D = get_node("Camera2D")
@onready var animals = get_node("Animals").get_children()
@onready var trees = get_node("Trees").get_children()
@onready var ground_layer: TileMapLayer = get_node("GroundLayer")
@onready var surface_layer: TileMapLayer = get_node("SurfaceLayer")

@onready var ui_canvas_layer = get_node("CanvasLayer")
@onready var ui = get_node("CanvasLayer/UI")

@onready var watering_can = get_node("%WateringCan")
@onready var powerlines = get_node("Infrastructure/PowerLineGroup")
@onready var generators = get_node("Infrastructure/Generators")
@onready var drawings = get_node("Drawings")
@onready var pig_path_follow = get_node("%TrappedPigPathFollow")
@onready var electrical_hum_audio = get_node("Infrastructure/ElectricalHumAudio")
@onready var fogs = get_node("Fogs")
@onready var audio_stream_player = get_node("AudioStreamPlayer")


var next_scene = Scenes.SCENE_1

var powerlines_quest_complete = false
var generators_quest_complete = false
var watering_holes_quest_complete = false
var trapped_pig_watering_hole_quest_complete = false
var revive_world = false
var world_revived = false

var pig_path_follow_distance = 0


func _ready():
	#TBD
	#audio_stream_player.finished.connect(_on_intro_music_finished)

	player.disable_collision()
	ship.disable_collision()
	_redraw_electricity()
	player.health_changed.connect(_on_health_changed)
	player.died.connect(_on_death)
	player.procrastination.connect(_on_procrastination)
	
	for tree in trees:
		tree.revived.connect(_on_object_revival)
		
		
	for animal in animals:
		animal.dug.connect(_on_animal_dug)
	
	for powerline in powerlines.get_children():
		powerline.has_broken.connect(_on_powerline_broken)
	
	for generator in generators.get_children():
		generator.has_broken.connect(_on_generator_broken)
		
	#TEST
	_on_intro_music_finished()


func _on_intro_music_finished():
	_play_cutscene()
	player.intro_cutscene = false
	ui.show()
	player.enable_collision()
	ship.enable_collision()
	ship.reparent(self)
	camera.limit_left = 0
	camera.limit_top = 20
	

func _on_object_revival():
	var all_water_bodies_filled = true
	
	for cell in ground_layer.get_used_cells():
		var atlas_coords = ground_layer.get_cell_atlas_coords(cell)
		if atlas_coords in TileCoords.EMPTY_WATER_BODY_CELLS:
			all_water_bodies_filled = false
			break
	
	if all_water_bodies_filled:
		watering_holes_quest_complete = true
		
	if trees.all(func(t): return t.is_revived) and watering_holes_quest_complete and powerlines_quest_complete:
		revive_world = true
		
	
func _on_animal_dug():
	if animals.all(func(a): return a.finished_digging):
		watering_can.unbury()
		player.start_physics_input()


func _on_health_changed():
	ui.set_health(player.health)
	

func _on_death():
	get_tree().change_scene_to_file("res://restart_overlay.tscn")

	
func _on_powerline_broken():
	_redraw_electricity()
	_check_all_powerlines_broken()


func _on_generator_broken():
	fogs.modulate.a -= 0.36
	if generators.get_children().all(func(p): return p.broken):
		generators_quest_complete = true
	

func _on_procrastination():
	ui.show_achievement(load("res://assets/achievements/procrastination.tres"))


func _redraw_electricity():
	drawings.working_powerlines = powerlines.get_children() \
		.filter(func(p): return !p.broken) \
		.map(func(p): return p.connector.global_position)


func _physics_process(delta: float) -> void:
	camera.global_position = lerp(camera.global_position, player.global_position, delta * LERP_SPEED)


func _process(delta):
	_set_z_index_for_surface_layer()
	
	if pig_path_follow.progress < pig_path_follow_distance:
		pig_path_follow.progress += 1.2


func _check_all_powerlines_broken():
	if powerlines.get_children().all(func(p): return p.broken):
		powerlines_quest_complete = true
		electrical_hum_audio.stop()
		if trapped_pig_watering_hole_quest_complete:
			pig_path_follow_distance = PIG_FOLLOW_SECOND_CHECKPOINT
		else:
			pig_path_follow_distance = PIG_FOLLOW_FIRST_CHECKPOINT


func _perform_revive_tile():
	var direction: Vector2i = player.last_velocity.sign()
	var map_cell = ground_layer.local_to_map(player.position) + direction
	var atlas_cell = ground_layer.get_cell_atlas_coords(map_cell)
	var cell_data = ground_layer.get_cell_tile_data(map_cell)
	
	if atlas_cell != -Vector2i.ONE:
		var is_water_body = cell_data.get_custom_data('water_body')
		
		if is_water_body:
			_revive_water_body(map_cell)


func _revive_water_body(map_cell):
	player.audio_stream_player.stream = Sounds.WATER_SOUND
	player.audio_stream_player.play()
	# For all used cells in tilemap
	var surrounding_cells = ground_layer.get_surrounding_cells(map_cell)
	var surrounding_water_cells = []
	
	for cell in surrounding_cells:
		if ground_layer.get_cell_tile_data(cell).get_custom_data('water_body'):
			if not surrounding_water_cells.has(cell):
				surrounding_water_cells.append(cell)
				surrounding_cells.append_array(ground_layer.get_surrounding_cells(cell))
	
	for water_cell in surrounding_water_cells:
		var alt_id = ground_layer.get_cell_alternative_tile(water_cell)
		var revived_atlas_cell = ground_layer.get_cell_tile_data(water_cell).get_custom_data('watered_tile')
			
		ground_layer.set_cell(water_cell, TileCoords.LUMINO_SOURCE, revived_atlas_cell, alt_id)
		
		if water_cell == TileCoords.TRAPPED_PIG_WATER_TILE:
			trapped_pig_watering_hole_quest_complete = true
			
			if pig_path_follow_distance == PIG_FOLLOW_FIRST_CHECKPOINT:
				pig_path_follow_distance = PIG_FOLLOW_SECOND_CHECKPOINT
				
	
	_on_object_revival()


func _input(event: InputEvent):
	if event.is_action_pressed("execute"):
		var performed = player.current_ability.perform(player)
		if not performed:
			_perform_on_tile(player.current_ability)
	elif event.is_action_pressed("tab"):
		player.switch_abilities()
		ui.change_ability(player.current_ability)


func _perform_on_tile(ability):
	if ability == Abilities.WATERING:
		_perform_revive_tile()
	

func _set_z_index_for_surface_layer():
	var surface_cell: Vector2i = surface_layer.local_to_map(player.position)

	if surface_cell in surface_layer.get_used_cells():
		player.z_index = 0
	elif player.global_position.y > 0:
		player.z_index = player.global_position.y
	else:
		player.z_index = 1


func _make_pigs_fly():
	for animal in animals:
		animal.evolve()
	
	
func _play_cutscene(scene = next_scene):
	var dialogue_box = DIALOGUE_BOX.instantiate()
	dialogue_box.scene = scene
	ui_canvas_layer.add_child(dialogue_box)
	dialogue_box.complete.connect(_on_dialogue_finished)
	player.stop_physics_input()


func _on_dialogue_finished(scene):
	player.start_physics_input()
	
	match scene:
		Scenes.SCENE_1: next_scene = Scenes.SCENE_2
		Scenes.SCENE_2: next_scene = null


func _on_scene_area_2_area_entered(area: Area2D) -> void:
	if next_scene == Scenes.SCENE_2:
		_play_cutscene()
	
	if generators_quest_complete and not player.available_abilities.has(Abilities.WATERING):
		player.stop_physics_input()
		for animal in animals:
			animal.dig(watering_can.global_position)
			await get_tree().create_timer(0.2).timeout
	
	if pig_path_follow.progress > PIG_FOLLOW_SECOND_CHECKPOINT - 2:
		powerlines_quest_complete = true
		
	if revive_world and not world_revived:
		world_revived = true
		for cell in ground_layer.get_used_cells():
			var alt_id = ground_layer.get_cell_alternative_tile(cell)
			var revived_atlas_cell = ground_layer.get_cell_tile_data(cell).get_custom_data('revived_tile')
			ground_layer.set_cell(cell, TileCoords.LUMINO_SOURCE, revived_atlas_cell, alt_id)
		

func _on_scene_area_3_area_entered(area: Area2D) -> void:
	if pig_path_follow.progress > PIG_FOLLOW_FIRST_CHECKPOINT - 2 and pig_path_follow_distance != PIG_FOLLOW_SECOND_CHECKPOINT:
		_play_cutscene(Scenes.SCENE_3)
