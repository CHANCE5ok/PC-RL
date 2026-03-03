extends TextureRect

@export var cup_size: String = "S"
@export var capacity_ml: int = 250

func _get_drag_data(_at_position: Vector2) -> Variant:
	var data := {
		"type": "cup",
		"size": cup_size,
		"capacity_ml": capacity_ml,
		"texture": texture
	}

	var preview := TextureRect.new()
	preview.texture = texture
	preview.custom_minimum_size = size
	set_drag_preview(preview)

	return data
