extends Control

@onready var orders_button = $OrdersButton
@onready var order_window = $OrderWindow
@onready var close_orders_button = $OrderWindow/PanelContainer/MarginContainer/VBoxContainer/CloseOrdersButton

@onready var title_label = $OrderWindow/PanelContainer/MarginContainer/VBoxContainer/Title
@onready var pastry_result_label = $OrderWindow/PanelContainer/MarginContainer/VBoxContainer/PastryResultLabel
@onready var error_count_label = $OrderWindow/PanelContainer/MarginContainer/VBoxContainer/ErrorCountLabel

var current_order = {
	"pastry": "croissant"
}

var player_result = {
	"pastry": ""
}

func _ready():
	order_window.hide()

	orders_button.pressed.connect(_on_orders_button_pressed)
	close_orders_button.pressed.connect(_on_close_orders_pressed)
	order_window.close_requested.connect(_on_close_orders_pressed)

func set_pastry(value: String):
	player_result["pastry"] = value

func _on_orders_button_pressed():
	update_order_window()
	order_window.popup_centered(Vector2i(500, 250))

func _on_close_orders_pressed():
	order_window.hide()

func check_order() -> Dictionary:
	var result = {}
	var errors = 0

	var is_correct = player_result["pastry"] == current_order["pastry"]
	result["pastry"] = is_correct

	if not is_correct:
		errors += 1

	result["errors"] = errors
	return result

func update_order_window():
	var check = check_order()

	title_label.text = "Заказ"
	pastry_result_label.text = "Кондитерское: " + translate_value(current_order["pastry"]) + " " + get_status_icon(check["pastry"])
	error_count_label.text = "Количество ошибок: " + str(check["errors"])

func get_status_icon(is_correct: bool) -> String:
	if is_correct:
		return "✅"
	else:
		return "❌"

func translate_value(value: String) -> String:
	match value:
		"croissant":
			return "круасан"
		"muffin":
			return "кекс"
		"donut":
			return "пончик"
		_:
			return value
