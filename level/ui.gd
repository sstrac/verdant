extends Control


@onready var current_ability = get_node("Control/Control/CurrentAbility")


func change_ability(ability: Ability):
	current_ability.texture = ability.texture
