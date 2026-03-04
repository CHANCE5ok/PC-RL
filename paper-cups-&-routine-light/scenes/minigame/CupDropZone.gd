extends Panel

func _gui_input(event):
	if event is InputEventMouseButton and not event.pressed:
		check_drop()

func check_drop():
	for child in get_tree().get_nodes_in_group("draggable_cup"):
		if child.dragging:
			if get_global_rect().has_point(child.get_global_mouse_position()):
				activate_cup(child)
			else:
				child.reset_position()

func activate_cup(cup):
	var minigame = get_node("/root/Minigame")
	minigame.set_active_cup(cup)
