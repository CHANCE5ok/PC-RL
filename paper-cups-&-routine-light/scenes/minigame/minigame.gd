extends Control

# =============================
# КАТЕГОРИИ
# =============================
@onready var tablet_panel = $TabletPanel
@onready var order_preview = $TabletPanel/OrderPreview
var active_cup = null
var categories = {
	"base": ["Espresso", "Americano"],
	"liquid": ["Milk", "Soy Milk"],
	"add-on": ["Caramel", "Vanilla"],
	"top": ["Foam", "Cinnamon"]
}

var category_keys = ["base", "liquid", "add-on", "top"]

var current_category_index = 0
var current_ingredient_index = 0

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
		"size": "M",
		"base": null,
		"ingredients": []
	},
	"drink_confirmed": null,
	"pastry": []
}

# =============================
# READY
# =============================

func _ready():

	$CoffeeScreen/IngredientSelector/LeftArrow.pressed.connect(_on_LeftArrow_pressed)
	$CoffeeScreen/IngredientSelector/RightArrow.pressed.connect(_on_RightArrow_pressed)
	$CoffeeScreen/AddButton.pressed.connect(_on_AddButton_pressed)
	$CoffeeScreen/NextButton.pressed.connect(_on_NextButton_pressed)
	$CoffeeScreen/ResetButton.pressed.connect(_on_ResetButton_pressed)

	$PastryScreen.visible = false
	$TabletPanel.visible = false
	
	update_ingredient_label()
	update_cup_visual()
	update_tablet_text()
	$PastryScreen.visible = false
	$TabletPanel.visible = false
	
	update_ingredient_label()
	update_cup_visual()
	update_tablet_text()
	
func set_active_cup(cup):

	# если уже есть активный стакан — запрещаем новый
	if active_cup != null:
		cup.reset_position()
		return

	active_cup = cup
	cup.locked = true
	
	cup.global_position = $CoffeeScreen/ActiveCupContainer.global_position
	build["drink"]["size"] = cup.cup_size
	
	print("Active cup:", cup.cup_size)

# =============================
# ВСПОМОГАТЕЛЬНЫЕ
# =============================

func get_current_category():
	return category_keys[current_category_index]

func get_current_ingredient():
	var cat = get_current_category()
	return categories[cat][current_ingredient_index]

# =============================
# ПЕРЕКЛЮЧЕНИЕ ИНГРЕДИЕНТОВ
# =============================

func _on_LeftArrow_pressed():
	
	current_ingredient_index -= 1
	if current_ingredient_index < 0:
		current_ingredient_index = categories[get_current_category()].size() - 1
	
	update_ingredient_label()

func _on_RightArrow_pressed():
	current_ingredient_index += 1
	if current_ingredient_index >= categories[get_current_category()].size():
		current_ingredient_index = 0
	
	update_ingredient_label()

# =============================
# ДОБАВИТЬ В СТАКАН
# =============================

func _on_AddButton_pressed():

	if active_cup == null:
		print("Place cup first")
		return

	var cat = get_current_category()
	var ing = get_current_ingredient()

	if cat == "base":
		start_brewing(ing)
	else:
		add_ingredient_to_cup(ing)
	
func start_brewing(base_name):
	var is_brewing = false

	if is_brewing:
		return

	is_brewing = true
	print("Brewing:", base_name)

	await get_tree().create_timer(2.0).timeout

	build["drink"]["base"] = base_name
	is_brewing = false

	update_cup_visual()
	
func add_ingredient_to_cup(ing):

	if build["drink"]["base"] == null:
		print("Add base first")
		return

	build["drink"]["ingredients"].append(ing)
	update_cup_visual()
	
func update_cup_visual():

	if active_cup == null:
		return

	var text = ""

	if build["drink"]["base"] != null:
		text += "Base: " + build["drink"]["base"] + "\n"

	for i in build["drink"]["ingredients"]:
		text += i + "\n"

	$CoffeeScreen/CupSlot/CupText.text = text
	
func is_drink_ready():
	return build["drink"]["base"] != null
	
func send_drink_to_tablet():

	if not is_drink_ready():
		print("Drink not ready")
		return

	build["drink_confirmed"] = build["drink"].duplicate(true)
	update_tablet_text()

# =============================
# СБРОС
# =============================

func _on_ResetButton_pressed():

	# очистка напитка
	build["drink"]["base"] = null
	build["drink"]["ingredients"].clear()

	# сброс категории
	current_category_index = 0
	current_ingredient_index = 0

	update_ingredient_label()
	update_cup_visual()
	reset_all_cups()
	
func reset_all_cups():

	for cup in get_tree().get_nodes_in_group("draggable_cup"):
		cup.locked = false
		cup.reset_position()

	active_cup = null

# =============================
# СЛЕДУЮЩАЯ КАТЕГОРИЯ
# =============================

func _on_NextButton_pressed():
	current_category_index += 1
	if current_category_index >= category_keys.size():
		current_category_index = 0
	
	current_ingredient_index = 0
	update_ingredient_label()

# =============================
# ВИЗУАЛ СТАКАНА
# =============================


	var text = ""
	
	if build["drink"]["base"] != null:
		text += "Base: " + build["drink"]["base"] + "\n"
	
	for i in build["drink"]["ingredients"]:
		text += i + "\n"
	
	$CoffeeScreen/CupSlot/CupText.text = text
	

# =============================
# ОБНОВЛЕНИЕ LABEL
# =============================

func update_ingredient_label():
	var cat = get_current_category()
	var ing = get_current_ingredient()
	
	$CoffeeScreen/IngredientSelector/IngredientLabel.text = cat + ": " + ing

# =============================
# ПЕРЕНОС В ПЛАНШЕТ
# =============================


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
	
	order_preview.text = text
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_E:
			toggle_tablet()

func toggle_tablet():
	$TabletPanel.visible = not $TabletPanel.visible
	
	if $TabletPanel.visible:
		update_tablet_preview()
		
func update_tablet_preview():
	var text = "ORDER:\n"
	text += "Size: " + order["drink"]["size"] + "\n"
	text += "Base: " + order["drink"]["base"] + "\n"
	text += "Ingredients: " + str(order["drink"]["ingredients"]) + "\n"
	text += "Pastry: " + str(order["pastry"]) + "\n"
	
	$TabletPanel/OrderPreview.text = text
	
func send_cup_to_tablet(cup):

	if active_cup == null:
		return
	
	build["drink_confirmed"] = build["drink"].duplicate(true)
	
	$TabletPanel/InventoryText.text = str(build["drink_confirmed"])
	
	$TabletPanel/ConfirmButton.visible = true
	$TabletPanel/CancelButton.visible = true
	
func _on_ConfirmButton_pressed():
	confirm_order()

func _on_CancelButton_pressed():
	build["drink_confirmed"] = null
	$TabletPanel/InventoryText.text = ""
	$TabletPanel/ConfirmButton.visible = false
	$TabletPanel/CancelButton.visible = false
# =============================
# ПОДТВЕРЖДЕНИЕ
# =============================

func confirm_order():
	var correct_drink = build["drink_confirmed"] == order["drink"]
	var correct_pastry = build["pastry"] == order["pastry"]
	
	var result = "fail"
	
	var is_brewing = false
	
	if correct_drink and correct_pastry:
		result = "perfect"
	elif correct_drink or correct_pastry:
		result = "normal"
	
	GameState.last_coffee_result = result
	close_minigame()
	

# =============================
# ЗАКРЫТИЕ
# =============================

func close_minigame():
	visible = false
	
	var dialogic = get_node_or_null("/root/DialogicGameHandler")
	if dialogic:
		dialogic.start("day1_client1_result")
