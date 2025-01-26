class_name StarRatingManager

enum StarRating {
	NONE,
	ONE_STAR,
	TWO_STARS,
	THREE_STARS
}

const STARS_TEXTURES = {
	StarRating.NONE: preload("res://assets/svg/empty_stars_level_end.svg"),
	StarRating.ONE_STAR: preload("res://assets/svg/one_star_filled_level_end.svg"),
	StarRating.TWO_STARS: preload("res://assets/svg/two_stars_filled_level_end.svg"),
	StarRating.THREE_STARS: preload("res://assets/svg/all_stars_filled_level_end.svg")
}
const FILE_PATH: String = "user://star_rating.save"


func save_rating(collectedStars: int, maxNumberOfStars: int, currentLevel: int) -> void:
	var starRatingsPerLevel = load_star_rating()
	if not starRatingsPerLevel:
		return
	
	var key = "level_" + str(currentLevel) + "_star_rating"
	var oldStarRating = starRatingsPerLevel[key]
	var newStarRating = get_rating(collectedStars, maxNumberOfStars)
	
	if newStarRating > oldStarRating:
		starRatingsPerLevel[key] = newStarRating
	
	save_data_to_file(starRatingsPerLevel)


func load_star_rating() -> Dictionary:
	var savedFile = load_saved_file()
	if not savedFile:
		create_file_with_default_values()
		savedFile = load_saved_file()
	
	var json = JSON.new()
	var jsonData = savedFile.get_line()
	var parseResult = json.parse(jsonData)
	if not parseResult == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", jsonData, " at line ", json.get_error_line())
		return {}
	
	var starRatingsPerLevel = json.data
	return starRatingsPerLevel


func load_saved_file() -> FileAccess:
	if not FileAccess.file_exists(FILE_PATH):
		return null
	else:
		return FileAccess.open(FILE_PATH, FileAccess.READ)


func create_file_with_default_values() -> void:
	var starRatingsPerLevel = {
		"level_1_star_rating": 0,
		"level_2_star_rating": 0,
		"level_3_star_rating": 0
	}
	save_data_to_file(starRatingsPerLevel)


func save_data_to_file(data: Dictionary) -> void:
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	var jsonData = JSON.stringify(data)
	file.store_line(jsonData)


func get_rating(collectedStars: int, maxNumberOfStars: int) -> int:
	var rating = StarRating.NONE
	
	if collectedStars >= maxNumberOfStars:
		rating = StarRating.THREE_STARS
	elif collectedStars >= float(maxNumberOfStars) / 2:
		rating = StarRating.TWO_STARS
	elif collectedStars >= 1:
		rating = StarRating.ONE_STAR
		
	return rating
