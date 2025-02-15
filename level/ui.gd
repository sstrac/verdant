extends Control


@onready var current_ability = get_node("Control/Control/CurrentAbility")
@onready var progress_bar = get_node("Control/ProgressBar")


func change_ability(ability: Ability):
	current_ability.texture = ability.texture


func set_health(health):
	progress_bar.visible = false
	progress_bar.value = health
	await get_tree().create_timer(0.2).timeout
	progress_bar.visible = true
