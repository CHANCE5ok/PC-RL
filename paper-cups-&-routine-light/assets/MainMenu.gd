extends Control

@onready var play_btn: Button = $PlayButton
@onready var continue_btn: Button = $ContinueButton
@onready var settings_btn: Button = $SettingsButton
@onready var exit_btn: Button = $ExitButton
@onready var settings_window: Window = $SettingsWindow
@onready var quit_confirm: ConfirmationDialog = $QuitConfirm
@onready var close_btn: Button = $SettingsWindow/Panel/SettingsUI/Close

func _ready():
	settings_window.close_requested.connect(_on_settings_close_requested)
	close_btn.pressed.connect(_on_settings_close_requested)

func _on_settings_close_requested() -> void:
	settings_window.hide()


	play_btn.pressed.connect(_on_play_pressed)
	continue_btn.pressed.connect(_on_continue_pressed)
	settings_btn.pressed.connect(_on_settings_pressed)
	exit_btn.pressed.connect(_on_exit_pressed)

	quit_confirm.confirmed.connect(_on_quit_confirmed)


func _on_play_pressed():
	print("PLAY")


func _on_continue_pressed():
	print("CONTINUE")


func _on_settings_pressed():
	settings_window.popup_centered()


func _on_exit_pressed():
	quit_confirm.popup_centered()


func _on_quit_confirmed():
	get_tree().quit()
