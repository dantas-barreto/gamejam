extends Control

@onready var no_deck_dialog: Panel = $NoDeckDialog

func _ready() -> void:
	no_deck_dialog.visible = false

func _on_start_pressed() -> void:
	var saved := PlayerDeck.load_saved()
	if saved != null and saved.is_valid():
		GameState.use_random_deck = false
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	else:
		no_deck_dialog.visible = true

func _on_deck_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/ui/DeckBuilder.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_random_deck_pressed() -> void:
	GameState.use_random_deck = true
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_build_deck_pressed() -> void:
	no_deck_dialog.visible = false
	get_tree().change_scene_to_file("res://Scenes/ui/DeckBuilder.tscn")

func _on_cancel_pressed() -> void:
	no_deck_dialog.visible = false
