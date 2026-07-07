class_name GameController extends Node2D

enum TurnState{
	PLAYER_TURN,
	ENEMY_TURN,
	ATTACK_TURN,
	GAME0VER, # TODO: fix typo (zero instead of O); update all references in main.gd and scenes
	VICTORY
}

@onready var current_state: TurnState = TurnState.PLAYER_TURN

# TODO: populate match arms with entry/exit logic per state (animations, UI signals, sound)
func transition(next_state: TurnState):
	match current_state:
		TurnState.PLAYER_TURN:
			pass
		TurnState.ENEMY_TURN:
			pass
		TurnState.ATTACK_TURN:
			pass
		TurnState.GAME0VER:
			pass
		TurnState.VICTORY:
			pass

	current_state = next_state

	match current_state:
		TurnState.PLAYER_TURN:
			pass
		TurnState.ENEMY_TURN:
			pass
		TurnState.ATTACK_TURN:
			pass
		TurnState.GAME0VER:
			pass
		TurnState.VICTORY:
			pass


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
