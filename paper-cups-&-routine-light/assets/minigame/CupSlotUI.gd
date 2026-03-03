extends Control

@onready var highlight = get_node_or_null("Highlight")
@onready var cup_preview = get_node_or_null("CupPreview")

var current_cup: Dictionary = {}
var fill_ml := 0


func _ready():
	if highlight:
		highlight.visible = false


# ✅ Проверка — можно ли сюда бросить стакан
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	var ok = typeof(data) == TYPE_DICTIONARY \
		and data.get("type", "") == "cup"

	if highlight:
		highlight.visible = ok

	return ok


# ✅ Когда стакан отпустили над кофемашиной
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	current_cup = data
	fill_ml = 0

	if cup_preview and data.has("texture"):
		cup_preview.texture = data["texture"]

	if highlight:
		highlight.visible = false
