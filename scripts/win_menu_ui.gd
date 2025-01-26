extends Control

@export var nextLevelButton: Button
@export var starRatingTextureRect: TextureRect
@export var currentLevel: int

const LEVELS_SCENES = {
	"1": "res://scenes/level_1.tscn",
	"2": "res://scenes/level_2.tscn",
	"3": "res://scenes/level_3.tscn",
}

var starRatingManager: StarRatingManager


func _ready() -> void:
	starRatingManager = StarRatingManager.new()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen_ui.tscn")


func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file(LEVELS_SCENES[str(currentLevel+1)])


func update_stars_based_on_score(collectedStars: int, maxNumberOfStars: int) -> void:
	var rating = starRatingManager.get_rating(collectedStars, maxNumberOfStars)
	starRatingTextureRect.texture = starRatingManager.STARS_TEXTURES[rating]


func save_star_rating(collectedStars: int, maxNumberOfStars: int) -> void:
	starRatingManager.save_rating(collectedStars, maxNumberOfStars, currentLevel)

func hide_next_level_button() -> void:
	nextLevelButton.hide()
