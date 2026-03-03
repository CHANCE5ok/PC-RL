extends Control

@onready var highlight = get_node_or_null("Highlight")
@onready var preview: TextureRect = $ItemPreview

var current_item: Dictionary = {}

func _ready():
	if highlight:
		highlight.visible = false
	preview.visible = false

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	var ok = typeof(data) == TYPE_DICTIONARY and data.get("type", "") == "pastry"
	if highlight:
		highlight.visible = ok
	return ok

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	current_item = data

	if data.has("texture"):
		preview.texture = data["texture"]
		preview.visible = true

	if highlight:
		highlight.visible = false

func reset_cashier():
	current_item = {}
	preview.visible = false
	preview.texture = null
	if highlight:
		highlight.visible = false
		
