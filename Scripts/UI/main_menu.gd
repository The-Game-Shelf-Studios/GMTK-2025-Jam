extends Control

@onready var main_menu_layer: CanvasLayer = $Main_Menu_Layer
@onready var credits_layer: CanvasLayer = $Credits_Layer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GameManager.initialize_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	GameManager.reset()
	GameManager.scene_transition("Play")

func _on_quit_button_pressed() -> void:
	GameManager.quit_game()

func _on_credits_button_pressed() -> void:
	credits_layer.visible = true
	main_menu_layer.visible = false


func _on_return_button_pressed() -> void:
	credits_layer.visible = false
	main_menu_layer.visible = true
