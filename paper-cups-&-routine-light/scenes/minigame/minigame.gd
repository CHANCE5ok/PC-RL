extends Control

# =============================
# ЗАКАЗ (пример)
# =============================

var order = {
	"drink": {
		"size": "M",
		"base": "Espresso",
		"ingredients": ["Milk"]
	},
	"pastry": ["Croissant"]
}

# =============================
# ЧТО СОБРАЛ ИГРОК
# =============================

var build = {
	"drink": {
		"size": null,
		"base": null,
		"ingredients": []
	},
	"drink_confirmed": null,
	"pastry": []
}

# =============================
# ИНИЦИАЛИЗАЦИЯ
# =============================

func _ready():
	$PastryScreen.visible = false
	$TabletPanel.visible = false
	update_tablet_text()

# =============================
# УПРАВЛЕНИЕ ЭКРАНАМИ
# =============================

func open_coffee():
	$CoffeeScreen.visible = true
	$PastryScreen.visible = false

func open_pastry():
	$CoffeeScreen.visible = false
	$PastryScreen.visible = true

# =============================
# СОБОРКА НАПИТКА
# =============================

func set_cup_size(value):
	build["drink"]["size"] = value

func set_drink_base(value):
	build["drink"]["base"] = value

func add_ingredient(value):
	build["drink"]["ingredients"].append(value)

func reset_drink():
	build["drink"] = {
		"size": null,
		"base": null,
		"ingredients": []
	}

# =============================
# ПЕРЕНОС В ПЛАНШЕТ
# =============================

func send_drink_to_tablet():
	# Копируем напиток как "готовый"
	build["drink_confirmed"] = build["drink"].duplicate(true)
	update_tablet_text()

func add_pastry(value):
	build["pastry"].append(value)
	update_tablet_text()

# =============================
# ПЛАНШЕТ
# =============================

func open_tablet():
	$TabletPanel.visible = true
	update_tablet_text()

func close_tablet():
	$TabletPanel.visible = false

func update_tablet_text():
	var text = "=== TABLET ===\n\n"
	
	text += "Drink:\n"
	text += str(build["drink_confirmed"]) + "\n\n"
	
	text += "Pastry:\n"
	text += str(build["pastry"]) + "\n"
	
	$TabletPanel/OrderText.text = text

# =============================
# ПОДТВЕРЖДЕНИЕ
# =============================

func confirm_order():
	var score = 0
	
	# Проверка напитка
	if build["drink_confirmed"] == order["drink"]:
		score += 1
	
	# Проверка выпечки
	if build["pastry"] == order["pastry"]:
		score += 1
	
	var result = "fail"
	
	if score == 2:
		result = "perfect"
	elif score == 1:
		result = "normal"
	
	GameState.last_coffee_result = result
	
	close_minigame()

# =============================
# ЗАВЕРШЕНИЕ
# =============================

func close_minigame():
	visible = false
	
	# Переход к таймлайну реакции
	var dialogic = get_node_or_null("/root/DialogicGameHandler")
	if dialogic:
		dialogic.start("day1_client1_result")
