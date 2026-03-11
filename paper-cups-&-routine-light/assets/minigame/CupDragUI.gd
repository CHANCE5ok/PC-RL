extends TextureRect

@export var cup_size: String = "small"
@export var capacity_ml: int = 250

func _get_drag_data(_at_position: Vector2) -> Variant:
	var data := {
		"type": "cup",
		"cup_size": cup_size,
		"capacity_ml": capacity_ml,
		"texture": texture
	}

	var preview := TextureRect.new()
	preview.texture = texture
	preview.custom_minimum_size = size
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_drag_preview(preview)

	return data
