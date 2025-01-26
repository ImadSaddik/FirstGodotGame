extends VBoxContainer

@export var starRatingTextureRectLevel1: TextureRect
@export var starRatingTextureRectLevel2: TextureRect
@export var starRatingTextureRectLevel3: TextureRect

var starRatingManager: StarRatingManager


func _ready() -> void:
	starRatingManager = StarRatingManager.new()


func update_star_rating_from_saved_data() -> void:
	var starRatingsPerLevel = starRatingManager.load_star_rating()
	var indexToTextureRect = {
		1: starRatingTextureRectLevel1,
		2: starRatingTextureRectLevel2,
		3: starRatingTextureRectLevel3,
	}
	for i in 3:
		var index = i + 1
		_set_texture({
			"texture_rect": indexToTextureRect[index],
			"level": index,
			"star_ratings_per_level": starRatingsPerLevel
		})


func _set_texture(data: Dictionary) -> void:
	var key = "level_" + str(data["level"]) + "_star_rating"
	var rating = data["star_ratings_per_level"][key]
	var textureRect = data["texture_rect"]
	textureRect.texture = starRatingManager.STARS_TEXTURES[int(rating)]
