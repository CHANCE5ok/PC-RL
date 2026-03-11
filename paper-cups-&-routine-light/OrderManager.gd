extends Node

var client_orders = [
	{
		"client_name": "Клиент 1",
		"order": {
			"cup_size": "large",
			"drink": "espresso",
			"doping": "caramel",
			"extra": "milk"
		}
	},
	{
		"client_name": "Клиент 2",
		"order": {
			"cup_size": "small",
			"drink": "hot_chocolate",
			"doping": "vanilla",
			"extra": "milk"
		}
	},
	{
		"client_name": "Клиент 3",
		"order": {
			"cup_size": "medium",
			"drink": "double_espresso",
			"doping": "syrop",
			"extra": "water"
		}
	},
	{
		"client_name": "Клиент 4",
		"order": {
			"cup_size": "large",
			"drink": "hot_chocolate",
			"doping": "caramel",
			"extra": "ice"
		}
	},
	{
		"client_name": "Клиент 5",
		"order": {
			"cup_size": "small",
			"drink": "espresso",
			"doping": "vanilla",
			"extra": "water"
		}
	},
	{
		"client_name": "Клиент 6",
		"order": {
			"cup_size": "medium",
			"drink": "hot_chocolate",
			"doping": "syrop",
			"extra": "milk"
		}
	},
	{
		"client_name": "Клиент 7",
		"order": {
			"cup_size": "large",
			"drink": "double_espresso",
			"doping": "vanilla",
			"extra": "ice"
		}
	},
	{
		"client_name": "Клиент 8",
		"order": {
			"cup_size": "medium",
			"drink": "espresso",
			"doping": "caramel",
			"extra": "milk"
		}
	},
	{
		"client_name": "Клиент 9",
		"order": {
			"cup_size": "small",
			"drink": "double_espresso",
			"doping": "syrop",
			"extra": "ice"
		}
	},
	{
		"client_name": "Клиент 10",
		"order": {
			"cup_size": "large",
			"drink": "hot_chocolate",
			"doping": "vanilla",
			"extra": "water"
		}
	}
]

var current_client_index := 0
var total_errors := 0

var player_progress = {
	"cup_size": "",
	"drink": "",
	"doping": "",
	"extra": ""
}

func get_current_client_name() -> String:
	return client_orders[current_client_index]["client_name"]

func get_current_order() -> Dictionary:
	return client_orders[current_client_index]["order"]

func reset_player_progress():
	player_progress = {
		"cup_size": "",
		"drink": "",
		"doping": "",
		"extra": ""
	}

func set_player_value(key: String, value: String):
	player_progress[key] = value

func get_player_value(key: String) -> String:
	return player_progress.get(key, "")

func add_errors(count: int):
	total_errors += count

func go_to_next_client():
	if current_client_index < client_orders.size() - 1:
		current_client_index += 1
		reset_player_progress()
	else:
		print("Все клиенты обслужены")

func is_last_client() -> bool:
	return current_client_index >= client_orders.size() - 1

func reset_all():
	current_client_index = 0
	total_errors = 0
	reset_player_progress()
