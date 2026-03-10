extends Button

@export var timeline_path := "res://scenes/day1.dtl"
@export var minigame_scene := "res://assets/minigame/coffeemascine.tscn" # поменяй

func _on_pressed() -> void:
	# спрятать меню (родитель MainMenu)
	var menu_root := get_node_or_null("../") # если кнопки лежат прямо в MainMenu
	if menu_root:
		menu_root.visible = false

	if Dialogic.timeline_ended.is_connected(_on_timeline_ended):
		Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	Dialogic.timeline_ended.connect(_on_timeline_ended)

	Dialogic.start(timeline_path)

func _on_timeline_ended() -> void:
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	get_tree().change_scene_to_file(minigame_scene)

func _on_dialogic_signal(arg: String) -> void:
	if arg == "start_minigame":
		Dialogic.signal_event.disconnect(_on_dialogic_signal)
		get_tree().change_scene_to_file(minigame_scene)
