extends TextureRect

var dragging = false
var original_position
var cup_size = "M" # поменяй для каждого стакана

func _ready():
	original_position = global_position

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
			else:
				dragging = false

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() - size / 2

func reset_position():
	global_position = original_position
