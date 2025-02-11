extends Node


class_name Scenes

const CHARACTER_TEXTURE = preload("res://assets/textures/characterSprite.png")
const PIG_TEXTURE = preload("res://assets/textures/pig.png")
const COMPANION_TEXTURE = preload("res://icon.svg")


const SCENE_1_CHARACTERS = {
	"right": COMPANION_TEXTURE,
	"left": CHARACTER_TEXTURE
}

const SCENE_1: Array = [
	"right:This is Globjulob...?", \
	"left:Seems a bit run down", \
	"right:My modules are tingling, something's not right. Let's look around", \
	"left:You're... modules?"
]
