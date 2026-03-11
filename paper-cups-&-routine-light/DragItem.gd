extends Control

@export var item_id: String = "croissant"
@export var item_texture: Texture2D

func _get_drag_data(_at_position: Vector2) -> Variant:
	var data := {
		"type": "pastry",
		"id": item_id,
		"texture": item_texture
	}

	# Появляется только во время перетаскивания
	var preview := TextureRect.new()
	preview.texture = item_texture
	preview.custom_minimum_size = Vector2(140, 140) # подгони под свои размеры
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_drag_preview(preview)

	return data
