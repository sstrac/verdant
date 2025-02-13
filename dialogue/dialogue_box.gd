extends Node2D

var tracker = 0
var finished: bool


@onready var left_sprite = get_node("LeftSprite")
@onready var right_sprite = get_node("RightSprite")
@onready var text = get_node("DialogueBox/RichTextLabel")

var scene


func _ready():
	_show_dialogue()
	
func _show_dialogue():
	var characters = scene.get('characters')
	var split_line = scene.get('script')[tracker].split(":")
	if split_line[0].to_lower() == "right":
		right_sprite.texture = characters["right"]
		right_sprite.show()
		left_sprite.hide()
	elif split_line[0].to_lower() == 'left':
		left_sprite.texture = characters["left"]
		left_sprite.show()
		right_sprite.hide()
	text.text = split_line[1]
	


func _input(event: InputEvent):
	if event.is_action_pressed("progress"):
		if not finished:
			tracker += 1
			_show_dialogue()
			
			if tracker + 1 == scene.size():
				finished = true
		else:
			queue_free()
		
