extends Control

enum StarRating {
	NONE,
	ONE_STAR,
	TWO_STARS,
	THREE_STARS
}

@export var nextLevelButton: Button
@export var starsImageContainer: TextureRect
@export var currentLevel: int

const STARS_TEXTURES = {
	StarRating.NONE: preload("res://assets/svg/empty_stars_level_end.svg"),
	StarRating.ONE_STAR: preload("res://assets/svg/one_star_filled_level_end.svg"),
	StarRating.TWO_STARS: preload("res://assets/svg/two_stars_filled_level_end.svg"),
	StarRating.THREE_STARS: preload("res://assets/svg/all_stars_filled_level_end.svg")
}

const LEVELS_SCENES = {
	"1": "res://scenes/level_1.tscn",
	"2": "res://scenes/level_2.tscn",
	"3": "res://scenes/level_3.tscn",
}

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen_ui.tscn")


func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file(LEVELS_SCENES[str(currentLevel+1)])


func update_stars_based_on_score(collectedStars: int, maxNumberOfStars: int) -> void:
	var rating = StarRating.NONE
	
	if collectedStars >= maxNumberOfStars:
		rating = StarRating.THREE_STARS
	elif collectedStars >= float(maxNumberOfStars) / 2:
		rating = StarRating.TWO_STARS
	elif collectedStars >= 1:
		rating = StarRating.ONE_STAR
		
	starsImageContainer.texture = STARS_TEXTURES[rating]
	

func hide_next_level_button() -> void:
	nextLevelButton.hide()
