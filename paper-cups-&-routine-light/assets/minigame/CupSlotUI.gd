extends Control

@onready var highlight = get_node_or_null("Highlight")
@onready var cup_preview = get_node_or_null("CupPreview")

var current_cup: Dictionary = {}
var fill_ml := 0


func _ready():
	if highlight:
		highlight.visible = false

	if cup_preview:
		cup_preview.visible = false


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	var ok = typeof(data) == TYPE_DICTIONARY and data.get("type", "") == "cup"

	if highlight:
		highlight.visible = ok

	return ok


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	current_cup = data
	fill_ml = 0

	if cup_preview and data.has("texture"):
		cup_preview.texture = data["texture"]
		cup_preview.visible = true

	if data.has("cup_size"):
		var minigame = get_node("/root/coffeemascine")
		minigame.set_cup_size(data["cup_size"])

	if highlight:
		highlight.visible = false
