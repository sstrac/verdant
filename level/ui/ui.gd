extends Control


@onready var current_ability = get_node("%CurrentAbility")
@onready var progress_bar = get_node("%ProgressBar")
@onready var audio_stream_player = get_node("AudioStreamPlayer")
@onready var achievement_popup = get_node("AchievementPopup")

func change_ability(ability: Ability):
	current_ability.texture = ability.texture


func set_health(health):
	progress_bar.visible = false
	progress_bar.value = health
	await get_tree().create_timer(0.2).timeout
	progress_bar.visible = true


func show_achievement(achievement: Achievement):
	audio_stream_player.play()
	achievement_popup.get_node("Label").text = achievement.text
	achievement_popup.texture = achievement.texture
	achievement_popup.show()
	await get_tree().create_timer(5).timeout
	achievement_popup.hide()
