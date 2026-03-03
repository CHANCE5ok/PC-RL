extends Button

func _pressed():
	get_parent().get_parent().reset_drink()
