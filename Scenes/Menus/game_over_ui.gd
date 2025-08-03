extends CanvasLayer

@onready var loss_label: Label = $LossLabel
@onready var victory_label: Label = $VictoryLabel

var checked_state := false

func _ready() -> void:
	GameManager.game_over_ui = self

func _process(delta: float) -> void:
	if !checked_state && GameManager.game_over:
		check_win_state()

func check_win_state() -> void:
	if GameManager.game_won:
		loss_label.visible = false
		victory_label.visible = true
	else:
		loss_label.visible = true
		victory_label.visible = false

func _on_menu_button_pressed() -> void:
	GameManager.scene_transition("Menu")

func _on_restart_button_pressed() -> void:
	GameManager.scene_transition("Play")
