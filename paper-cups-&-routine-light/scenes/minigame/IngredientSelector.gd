extends Control

var ingredients = ["Espresso", "Milk", "Syrup"]
var index = 0

func _ready():
	update_label()

func next():
	index += 1
	if index >= ingredients.size():
		index = 0
	update_label()

func prev():
	index -= 1
	if index < 0:
		index = ingredients.size() - 1
	update_label()

func add_selected():
	get_parent().get_parent().add_ingredient(ingredients[index])

func update_label():
	$IngredientLabel.text = ingredients[index]
