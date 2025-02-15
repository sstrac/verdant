extends Node2D

const NUMBER_DISTORTION_POINTS = 5
const MAX_DEVIATION = 5

@onready var timer: Timer = get_node("Timer")

var distortion_points = []
var working_powerlines = []:
	set(p):
		working_powerlines = p
		recalculate_distortion_points()
		queue_redraw()


func _ready():
	timer.timeout.connect(recalculate_distortion_points)
	timer.start()
	z_index = 999


func recalculate_distortion_points():
	distortion_points = []
	var i = 1
	
	while i < working_powerlines.size():
		_create_distortion_points(i-1, i)
		i += 1
	
	# Connect first and last powerline
	if working_powerlines.size() > 2 or working_powerlines.size() == 1:
		_create_distortion_points(0, working_powerlines.size() - 1)
	
	queue_redraw()

func _create_distortion_points(i_start, i_end):
	var line = []
	var anchor: Vector2 = working_powerlines[i_start]
	line.append(working_powerlines[i_start])

	var difference = working_powerlines[i_end] - working_powerlines[i_start]
	var gap = difference / NUMBER_DISTORTION_POINTS
	for j in range(NUMBER_DISTORTION_POINTS - 1):
		var distortion_point: Vector2 = working_powerlines[i_start] + ((j + 1) * gap)
		distortion_point += Vector2(randf_range(-MAX_DEVIATION, MAX_DEVIATION), randf_range(-MAX_DEVIATION, MAX_DEVIATION))
		line.append(distortion_point)
	
	line.append(working_powerlines[i_end])
	distortion_points.append(line)
		

func _draw():
	for line in distortion_points:
		var i = 1
		while i < line.size():
			draw_line(line[i-1], line[i], Color.YELLOW, 1.0)
			i += 1
