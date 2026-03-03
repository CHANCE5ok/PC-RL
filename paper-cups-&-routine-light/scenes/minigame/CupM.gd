extends TextureRect

@export var item_type : String
@export var item_value : String

func _get_drag_data(at_position):
	set_drag_preview(duplicate())
	return {
		"type": item_type,
		"value": item_value
	}
