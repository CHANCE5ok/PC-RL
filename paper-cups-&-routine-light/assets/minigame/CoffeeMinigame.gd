extends Node2D

@onready var orders_window = $CanvasLayer/OrderWindow
@onready var orders_button = $CanvasLayer/OrdersButton
@onready var close_orders_button = $CanvasLayer/OrderWindow/PanelContainer/MarginContainer/VBoxContainer/CloseOrdersButton

@onready var left_button = $CanvasLayer/ButtonLeft
@onready var center_button = $CanvasLayer/ButtonCenter
@onready var right_button = $CanvasLayer/ButtonRight
@onready var add_button = $CanvasLayer/ButtonAdd
@onready var reset_button = $CanvasLayer/ButtonReset

@onready var cup_result_label = $CanvasLayer/OrderWindow/PanelContainer/MarginContainer/VBoxContainer/CupResultLabel
@onready var drink_result_label = $CanvasLayer/OrderWindow/PanelContainer/MarginContainer/VBoxContainer/DrinkResultLabel
@onready var topping_result_label = $CanvasLayer/OrderWindow/PanelContainer/MarginContainer/VBoxContainer/ToppingResultLabel
@onready var extra_result_label = $CanvasLayer/OrderWindow/PanelContainer/MarginContainer/VBoxContainer/KondResultLabel
@onready var error_count_label = $CanvasLayer/OrderWindow/PanelContainer/MarginContainer/VBoxContainer/ErrorCountLabel
@onready var title_label = $CanvasLayer/OrderWindow/PanelContainer/MarginContainer/VBoxContainer/Title

# 3 набора для этой сцены:
# 0 = напиток
# 1 = допинг
# 2 = добавка
var sets = [
	["espresso", "double_espresso", "hot_chocolate"],
	["syrop", "caramel", "vanilla"],
	["water", "milk", "ice"]
]

var current_set_index := 0
var index := 0

# Заказ клиента
var current_order = {
	"cup_size": "large",
	"drink": "espresso",
	"doping": "caramel",
	"extra": "milk"
}

# Что выбрал игрок
var player_result = {
	"cup_size": "",
	"drink": "",
	"doping": "",
	"extra": ""
}

func _ready():
	orders_window.hide()

	left_button.pressed.connect(_on_button_left_pressed)
	right_button.pressed.connect(_on_button_right_pressed)
	add_button.pressed.connect(_on_button_add_pressed)
	reset_button.pressed.connect(_on_button_reset_pressed)

	orders_button.pressed.connect(_on_orders_button_pressed)
	close_orders_button.pressed.connect(_on_close_orders_pressed)
	orders_window.close_requested.connect(_on_close_orders_pressed)

	_update_center_text()


# ---------- КНОПКИ ВЫБОРА ----------

func _on_button_left_pressed():
	index = (index - 1 + sets[current_set_index].size()) % sets[current_set_index].size()
	_update_center_text()


func _on_button_right_pressed():
	index = (index + 1) % sets[current_set_index].size()
	_update_center_text()


func _on_button_add_pressed():
	current_set_index = (current_set_index + 1) % sets.size()
	index = 0
	_update_center_text()


func _on_button_reset_pressed():
	current_set_index = 0
	index = 0

	player_result["drink"] = ""
	player_result["doping"] = ""
	player_result["extra"] = ""
	player_result["cup_size"] = ""

	_update_center_text()


func _update_center_text():
	var current_value = sets[current_set_index][index]
	center_button.text = translate_value(current_value)
	save_current_selection()


func save_current_selection():
	var current_value = sets[current_set_index][index]

	if current_set_index == 0:
		player_result["drink"] = current_value
	elif current_set_index == 1:
		player_result["doping"] = current_value
	elif current_set_index == 2:
		player_result["extra"] = current_value


# ---------- СТАКАН ----------
# ЭТУ ФУНКЦИЮ ДОЛЖНЫ ВЫЗЫВАТЬ ТВОИ СТАКАНЫ ПРИ УСТАНОВКЕ В CupSlot

func set_cup_size(size: String):
	player_result["cup_size"] = size


# ---------- ОКНО ЗАКАЗОВ ----------

func _on_orders_button_pressed():
	update_orders_window()
	orders_window.popup_centered(Vector2i(700, 500))


func _on_close_orders_pressed():
	orders_window.hide()


func check_order() -> Dictionary:
	var result = {}
	var errors = 0

	for key in current_order.keys():
		var is_correct = player_result[key] == current_order[key]
		result[key] = is_correct

		if not is_correct:
			errors += 1

	result["errors"] = errors
	return result


func update_orders_window():
	var check = check_order()

	cup_result_label.text = "Стакан: " + translate_value(current_order["cup_size"]) + " " + get_status_icon(check["cup_size"])
	drink_result_label.text = "Напиток: " + translate_value(current_order["drink"]) + " " + get_status_icon(check["drink"])
	topping_result_label.text = "Допинг: " + translate_value(current_order["doping"]) + " " + get_status_icon(check["doping"])
	extra_result_label.text = "Добавка: " + translate_value(current_order["extra"]) + " " + get_status_icon(check["extra"])

	error_count_label.text = "Количество ошибок: " + str(check["errors"])

func get_status_icon(is_correct: bool) -> String:
	if is_correct:
		return "✅"
	else:
		return "❌"


func translate_value(value: String) -> String:
	match value:
		"small":
			return "маленький"
		"medium":
			return "средний"
		"large":
			return "большой"

		"espresso":
			return "эспрессо"
		"double_espresso":
			return "двойной эспрессо"
		"hot_chocolate":
			return "горячий шоколад"

		"syrop":
			return "сироп"
		"caramel":
			return "карамель"
		"vanilla":
			return "ваниль"

		"water":
			return "вода"
		"milk":
			return "молоко"
		"ice":
			return "лёд"

		"":
			return "не выбрано"
		_:
			return value
