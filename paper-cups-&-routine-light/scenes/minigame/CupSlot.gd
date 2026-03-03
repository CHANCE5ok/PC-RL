extends Control

func _can_drop_data(position, data):
	return data.has("type") and data["type"] == "cup"

func _drop_data(position, data):
	var mg = get_meta("minigame")
	mg.set_cup_size(data["value"])
