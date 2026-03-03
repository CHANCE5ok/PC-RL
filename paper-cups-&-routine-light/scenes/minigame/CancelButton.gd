extends Button

func _pressed():
	get_parent().get_parent().close_tablet()
