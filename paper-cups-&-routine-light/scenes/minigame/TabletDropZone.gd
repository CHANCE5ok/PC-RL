extends Panel

func _gui_input(event):
	if event is InputEventMouseButton and not event.pressed:
		check_drop()

func check_drop():
	for cup in get_tree().get_nodes_in_group("draggable_cup"):
		if cup.dragging:
			if get_global_rect().has_point(cup.get_global_mouse_position()):
				var minigame = get_node("/root/Minigame")
				minigame.send_cup_to_tablet(cup)
