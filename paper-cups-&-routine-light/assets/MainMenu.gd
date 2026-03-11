extends Control

@onready var play_btn: Button = $PlayButton
@onready var continue_btn: Button = $ContinueButton
@onready var settings_btn: Button = $SettingsButton
@onready var exit_btn: Button = $ExitButton

@onready var settings_window: Window = $SettingsWindow
@onready var quit_confirm: ConfirmationDialog = $QuitConfirm
@onready var close_btn: Button = $SettingsWindow/Panel/Root/SettingsUI/ButtonsRow/CloseButton


func _ready():

	# закрытие окна настроек
	settings_window.close_requested.connect(_on_settings_close_requested)
	close_btn.pressed.connect(_on_settings_close_requested)

	# кнопки меню
	play_btn.pressed.connect(_on_play_pressed)
	continue_btn.pressed.connect(_on_continue_pressed)
	settings_btn.pressed.connect(_on_settings_pressed)
	exit_btn.pressed.connect(_on_exit_pressed)

	# подтверждение выхода
	quit_confirm.confirmed.connect(_on_quit_confirmed)


# ---------- SETTINGS ----------

func _on_settings_pressed():
	settings_window.popup_centered(Vector2i(1000, 700))


func _on_settings_close_requested():
	settings_window.hide()


# ---------- PLAY ----------

func _on_play_pressed():

	print("PLAY pressed")

	# подключаем сигнал окончания диалога
	if Dialogic.timeline_ended.is_connected(_on_dialog_end):
		Dialogic.timeline_ended.disconnect(_on_dialog_end)

	Dialogic.timeline_ended.connect(_on_dialog_end)

	# запускаем диалог
	Dialogic.start("day1")


func _on_dialog_end():

	Dialogic.timeline_ended.disconnect(_on_dialog_end)

	# переход в мини игру
	get_tree().change_scene_to_file("res://assets/minigame/coffeemascine.tscn")


# ---------- CONTINUE ----------

func _on_continue_pressed():
	print("CONTINUE")


# ---------- EXIT ----------

func _on_exit_pressed():
	quit_confirm.popup_centered(Vector2i(500, 250))


func _on_quit_confirmed():
	get_tree().quit()
