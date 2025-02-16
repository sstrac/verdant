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
		"left:The scanners said this planet was a verdant paradise... what the hell happened?",
		"right:The scanners were last updated 12,436 years ago, it seems a civilisation grew and collapsed within that timeframe.",
		"left:How could they destroy their own planet in only 12,000 years!",
		"right:12,436 years. Perhaps we can look around and reverse some of the damages."
	]
}

const SCENE_2: Dictionary = {
	'characters': {
		"right": COMPANION_TEXTURE,
		"left": CHARACTER_TEXTURE
	},
	'script':
	[
		"left:They have pigs on this planet?! They're so cute!",
		"right:Pigs, the latin 'porcus', is a species native to earth. What could they be doing on this planet?",
		"left:Are they coughing? They dont look healthy.",
		"right:It seems the atmosphere of this planet is unusually thick with smog, perhaps we could assist."
		
	]
}

const SCENE_3: Dictionary = {
	'characters': {
		"right": COMPANION_TEXTURE,
		"left": CHARACTER_TEXTURE
	},
	'script':
	[
		"right:Perhaps this pig is searching for a watering hole."
	]
}

const SCENE_NEW_ITEM: Dictionary = {
	'characters': {
		"right": COMPANION_TEXTURE,
		"left": CHARACTER_TEXTURE
	},
	'script':
	[
		"right:You seem to have found a new item, switch to it by pressing 'TAB'... It is a button in your spacesuit."
	]
}

const SCENE_LONELY_PIGS: Dictionary = {
	'characters': {
		"right": COMPANION_TEXTURE,
		"left": CHARACTER_TEXTURE
	},
	'script':
	[
		"right:The vital signs of these pigs seem to be improving.",
		"left:Something still seems off about them.. maybe they're lonely?",
		"right:Earth pigs have been known to seek out the company of other pigs and often huddle to maintain physical contact.",
		"left:Maybe we can find others somewhere, reunite the family."
	]
}

const SCENE_PIG_EVOLUTION: Dictionary = {
	'characters': {
		"right": COMPANION_TEXTURE,
		"left": CHARACTER_TEXTURE
	},
	'script':
	[
		"left:There we go, the pigs look so much happier!",
		"right:I am detecting strange deviations in the pigs molecular structure, perhaps we should stand back.",
		"left:WHAT?! Oh. My. God!"
	]
}

const SCENE_PIG_EVOLUTION_FOLLOWUP: Dictionary = {
	'characters': {
		"right": COMPANION_TEXTURE,
		"left": CHARACTER_TEXTURE
	},
	'script':
	[
		"left:Well I never thought I'd see a pig fly!",
		"right:...",
		"left:Nothing to say?",
		"right:...My databases have no precident for this.",
		"left:Huh, Guess we're both stumped then. Let's head back to the ship."
	]
}
