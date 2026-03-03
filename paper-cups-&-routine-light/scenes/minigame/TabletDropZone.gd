extends Control

func _can_drop_data(pos, data):
	return true

func _drop_data(pos, data):
	var root = get_parent().get_parent()
	
	if data["type"] == "size":
		root.set_size(data["value"])
	
	if data["type"] == "pastry":
		root.add_pastry(data["value"])
	
	root.update_tablet_text()
