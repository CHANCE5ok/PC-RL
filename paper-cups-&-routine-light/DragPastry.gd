extends TextureRect

@export var pastry_type: String = "croissant"

func _get_drag_data(_at_position: Vector2) -> Variant:
	var data := {
		"type": "pastry",
		"pastry": pastry_type,
		"texture": texture
	}

	var preview := TextureRect.new()
	preview.texture = texture
	preview.custom_minimum_size = size
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_drag_preview(preview)

	return data
