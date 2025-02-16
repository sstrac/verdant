extends Interactable


const TREE_DEAD = preload("res://assets/textures/fauna_flora/tree_dead.png")
const TREE_0 = preload("res://assets/textures/fauna_flora/tree_0.png")
const TREE_1 = preload("res://assets/textures/fauna_flora/tree_1.png")
const TREE_2 = preload("res://assets/textures/fauna_flora/tree_2.png")
const TREE_3 = preload("res://assets/textures/fauna_flora/tree_3.png")

@onready var rect = get_node("TextureRect")
@onready var timer = get_node("Timer")
@onready var particles = get_node("CPUParticles2D")

var is_revived = false

signal revived


func _ready():
	z_index = position.y
	timer.timeout.connect(grow)
	

func interact(_player):
	if waterable:
		rect.texture = TREE_0
		timer.start()
		waterable = false
		is_revived = true
		revived.emit()


func grow():
	match rect.texture:
		TREE_0: rect.texture = TREE_1
		TREE_1: rect.texture = TREE_2
		TREE_2: rect.texture = TREE_3; particles.emitting = true
	
	if rect.texture == TREE_3:
		timer.stop()
