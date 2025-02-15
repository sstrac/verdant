extends Node


class_name Scenes

const CHARACTER_TEXTURE = preload("res://assets/textures/dialogue/dialogue_character.png")
const PIG_TEXTURE = preload("res://assets/textures/fauna_flora/pig.png")
const COMPANION_TEXTURE = preload("res://assets/textures/dialogue/dialogue_companion.png")


const SCENE_1: Dictionary = {
	'characters': {
		"right": COMPANION_TEXTURE,
		"left": CHARACTER_TEXTURE
	},
	'script':
	[
		"right:This is Globjulob...?",
		"left:Seems a bit run down",
		"right:My modules are tingling, something's not right. Let's look around",
		"left:You're... modules?"
	]
}

const SCENE_2: Dictionary = {
	'characters': {
		"right": COMPANION_TEXTURE,
		"left": CHARACTER_TEXTURE
	},
	'script':
	[
		"right:These are so cute!",
		"left:They look a lot like Earth pigs. But what would they be doing here?",
		"right:They're aren't many of them, I wonder if there are others somewhere",
	]
}

const SCENE_3: Dictionary = {
	'characters': {
		"right": COMPANION_TEXTURE,
		"left": CHARACTER_TEXTURE
	},
	'script':
	[
		"right:It's looking to drink"
	]
}
