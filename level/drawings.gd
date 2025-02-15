extends Node2D

const NUMBER_DISTORTION_POINTS = 5
const MAX_DEVIATION = 5

@onready var timer: Timer = get_node("Timer")

var distortion_points = []
var powerlines = []:
	set(p):
		powerlines = p
		recalculate_distortion_points()
		queue_redraw()


func _ready():
	timer.timeout.connect(recalculate_distortion_points)
	timer.start()
	z_index = 999


func recalculate_distortion_points():
	distortion_points = []
	var i = 1
	
	while i < powerlines.size():
		_create_distortion_points(i-1, i)
		i += 1
	
	if not powerlines.size() == 0:
		_create_distortion_points(0, powerlines.size() - 1)
	
	queue_redraw()

func _create_distortion_points(i_start, i_end):
	var line = []
	var anchor: Vector2 = powerlines[i_start]
	line.append(powerlines[i_start])
	
	if powerlines.size() > 2:
		var difference = powerlines[i_end] - powerlines[i_start]
		var gap = difference / NUMBER_DISTORTION_POINTS
		for j in range(NUMBER_DISTORTION_POINTS):
			var distortion_point: Vector2 = powerlines[i_start] + ((j + 1) * gap)
			distortion_point += Vector2(randf_range(-MAX_DEVIATION, MAX_DEVIATION), randf_range(-MAX_DEVIATION, MAX_DEVIATION))
			line.append(distortion_point)
	line.append(powerlines[i_end])
	distortion_points.append(line)
		

func _draw():
	for line in distortion_points:
		var i = 1
		while i < line.size():
			draw_line(line[i-1], line[i], Color.YELLOW, 1.0)
			i += 1
