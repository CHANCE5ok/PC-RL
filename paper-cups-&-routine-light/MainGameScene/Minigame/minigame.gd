extends CanvasLayer

func _ready():
	visible = false

func open():
	print("MINIGAME OPENED")
	visible = true

func close():
	visible = false

func _on_perfect_pressed():
	GameState.last_coffee_result = "perfect"
	close()
	$"/root/Game/DialogicGameHandler".start("day1_client1_perfect")

func _on_normal_pressed():
	GameState.last_coffee_result = "normal"
	close()
	$"/root/Game/DialogicGameHandler".start("day1_client1_normal")

func _on_fail_pressed():
	GameState.last_coffee_result = "fail"
	close()
	$"/root/Game/DialogicGameHandler".start("day1_client1_fail")
	
