extends Control

@onready var highlight = $Highlight
@onready var item_preview = $ItemPreview

func _ready():
	highlight.visible = false
	item_preview.visible = false

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	var ok = typeof(data) == TYPE_DICTIONARY and data.get("type", "") == "pastry"
	highlight.visible = ok
	return ok

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if data.has("texture"):
		item_preview.texture = data["texture"]
		item_preview.visible = true

	if data.has("pastry"):
		var scene = get_node("/root/PastryMinigame")
		scene.set_pastry(data["pastry"])

	highlight.visible = false
