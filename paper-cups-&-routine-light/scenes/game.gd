extends Node

func _ready():
	$DialogicGameHandler.start("day1")

func open_minigame():
	$MiniGame.open()
