extends Control

@onready var play_btn = $PlayButton
@onready var continue_btn = $ContinueButton
@onready var settings_btn = $SettingsButton
@onready var exit_btn = $ExitButton

@onready var settings_window = $SettingsWindow
@onready var music_slider = $SettingsWindow/Panel/Root/SettingsUI/MusicSlider
@onready var close_button = $SettingsWindow/Panel/Root/SettingsUI/CloseButton

@onready var quit_confirm = $QuitConfirm

func _ready():
	settings_window.hide()

	play_btn.pressed.connect(_on_play_pressed)
	continue_btn.pressed.connect(_on_continue_pressed)
	settings_btn.pressed.connect(_on_settings_pressed)
	exit_btn.pressed.connect(_on_exit_pressed)

	close_button.pressed.connect(_on_close_settings_pressed)
	settings_window.close_requested.connect(_on_close_settings_pressed)

	quit_confirm.confirmed.connect(_on_quit_confirmed)

	quit_confirm.title = "Выход"
	quit_confirm.dialog_text = "Вы уверены, что хотите выйти из игры?"

func _on_continue_pressed():
	print("CONTINUE")

func _on_settings_pressed():
	settings_window.popup_centered(Vector2i(700, 450))

func _on_close_settings_pressed():
	settings_window.hide()

func _on_exit_pressed():
	quit_confirm.popup_centered(Vector2i(500, 250))

func _on_quit_confirmed():
	get_tree().quit()
	
func _on_play_pressed():
	hide()
	if Dialogic.timeline_ended.is_connected(_on_dialog_end):
		Dialogic.timeline_ended.disconnect(_on_dialog_end)

	Dialogic.timeline_ended.connect(_on_dialog_end)
	Dialogic.start("day1")

func _on_dialog_end():
	Dialogic.timeline_ended.disconnect(_on_dialog_end)
	get_tree().change_scene_to_file("res://assets/minigame/coffeemascine.tscn")
