extends Node2D

const NUMBER_DISTORTION_POINTS = 5
const MAX_DEVIATION = Vector2(2, 2)

@onready var timer: Timer = get_node("Timer")

var distortion_points = []
var powerlines = []:
	set(p):
		powerlines = p
		recalculate_distortion_points()
		queue_redraw()


func recalculate_distortion_points():
	distortion_points = []
	var i = 1
	while i < powerlines.size():
		var line = []
		var anchor = powerlines[i-1]
		line.append(powerlines[i-1])
		for j in range(NUMBER_DISTORTION_POINTS):
			
			var middle = powerlines[i-1] + (powerlines[i] - powerlines[i-1]) / 2
			var range_end
			if anchor < middle:
				range_end = middle
			else:
				range_end = powerlines[i]
			var rand_x = randf_range(anchor.x, range_end.x)
			var rand_y = randf_range(anchor.y, range_end.y)
			anchor = Vector2(rand_x, rand_y)
			
			line.append(anchor)
		line.append(powerlines[i])
		distortion_points.append(line)
		i += 1
	
	queue_redraw()


func _ready():
	timer.timeout.connect(recalculate_distortion_points)
	timer.start()
	
# Called when the node enters the scene tree for the first time.
func _draw():
	for line in distortion_points:
		var i = 1
		while i < line.size():
			draw_line(line[i-1], line[i], Color.YELLOW, 1.0)
			i += 1
