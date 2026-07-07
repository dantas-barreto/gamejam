class_name GameController extends Node2D

enum TurnState{
	PLAYER_TURN,
	ENEMY_TURN,
	ATTACK_TURN,
	GAME0VER,
	VICTORY
}

@onready var current_state: TurnState = TurnState.PLAYER_TURN

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
