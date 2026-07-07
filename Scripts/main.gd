extends Node2D

@export var player_character: Character
@export var enemy_character: Character

@onready var game_control:GameController = $GameController
@onready var player_deck_in_hand: Node2D = $PlayerDeckInHand
@onready var enemy_deck_in_hand: Node2D = $EnemyDeckInHand
@onready var deck_ui: PlayableDeckUI = $PlayableDeckUi

@onready var player_deck: Deck = Deck.new()
@onready var enemy_deck: Deck = Deck.new()

var rng = RandomNumberGenerator.new()

var enemy_playable_deck: PlayableDeck

var objective: int = 0
var amount_objective: int = 0
var objective_card

func restart_game():
	game_control.current_state = GameController.TurnState.PLAYER_TURN
	$MainScreen/PlayerCharacter.reset()
	$MainScreen/EnemyCharacter.reset()
	player_deck_in_hand.reset()
	enemy_deck_in_hand.reset()
	deck_ui.deck = player_deck.get_playable_deck()
	enemy_playable_deck = enemy_deck.get_playable_deck()
	$CanvasLayer/StartScreen.visible = true

func _ready() -> void:
	player_deck_in_hand.deck = player_deck
	enemy_deck_in_hand.deck = enemy_deck
	deck_ui.deck = player_deck.get_playable_deck()

func _process(delta: float) -> void:
	
	if(objective > 0):
		if(amount_objective > 3):
			objective_card.activate({
			"caster": $MainScreen/PlayerCharacter,
			"your_monster": player_deck_in_hand.table.table,
			"targets": enemy_deck_in_hand.table.table,
			"enemy": $MainScreen/EnemyCharacter
			})
	
	if $MainScreen/PlayerCharacter.health <= 0:
		game_control.transition(GameController.TurnState.GAME0VER)
	elif $MainScreen/EnemyCharacter.health <= 0:
		game_control.transition(GameController.TurnState.VICTORY)
	
	if game_control.current_state == GameController.TurnState.ENEMY_TURN:
		for i in 3:
			if(enemy_deck_in_hand.hand.hand.is_empty()):
				pass
			else:
				var choosed_card: UsableCard = enemy_deck_in_hand.hand.hand[rng.randi_range(0, enemy_deck_in_hand.hand.hand.size() - 1)]
				choosed_card.set_rotation(deg_to_rad(0))
				enemy_deck_in_hand._on_hand_card_transfer_to_table(choosed_card)
				print(choosed_card)
		
		game_control.transition(GameController.TurnState.ATTACK_TURN)
		for creature in player_deck_in_hand.table.table:
			creature.attack({
			"caster": $MainScreen/PlayerCharacter,
			"your_monster": player_deck_in_hand.table.table,
			"targets": enemy_deck_in_hand.table.table,
			"enemy": $MainScreen/EnemyCharacter
			})
		for creature in enemy_deck_in_hand.table.table:
			creature.attack({
			"caster": $MainScreen/EnemyCharacter,
			"your_monster": enemy_deck_in_hand.table.table,
			"targets": player_deck_in_hand.table.table,
			"enemy": $MainScreen/PlayerCharacter
			})
			
		game_control.transition(GameController.TurnState.PLAYER_TURN)
		if(!deck_ui.is_empty()):
			var card_with_id = deck_ui.draw()
			player_deck_in_hand.add_card(card_with_id)
		for structure in player_deck_in_hand.table.structures:
			structure.activate_in_play({
			"caster": $MainScreen/PlayerCharacter,
			"your_monster": player_deck_in_hand.table.table,
			"targets": enemy_deck_in_hand.table.table,
			"enemy": $MainScreen/EnemyCharacter
			})
		for creature in player_deck_in_hand.table.table:
			creature.activate_in_play({
			"caster": $MainScreen/PlayerCharacter,
			"your_monster": player_deck_in_hand.table.table,
			"targets": enemy_deck_in_hand.table.table,
			"enemy": $MainScreen/EnemyCharacter
			})
		$MainScreen/PlayerCharacter.start_turn()
	
	if game_control.current_state == GameController.TurnState.VICTORY:
		$CanvasLayer/VictoryOverlay.visible = true
	else:
		$CanvasLayer/VictoryOverlay.visible = false
	
	if game_control.current_state == GameController.TurnState.GAME0VER:
		$CanvasLayer/GameOverOverlay.visible = true
	else:
		$CanvasLayer/GameOverOverlay.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action("restart"):
		restart_game()

func _on_table_card_activated(card: UsableCard) -> void:
	var card_cost: int = card.get_cost()
	if game_control.current_state == GameController.TurnState.PLAYER_TURN:
		card.activate({
		"caster": $MainScreen/PlayerCharacter,
		"your_monster": player_deck_in_hand.table.table,
		"targets": enemy_deck_in_hand.table.table,
		"enemy": $MainScreen/EnemyCharacter,
		"objective": objective_card
	})
	elif game_control.current_state == GameController.TurnState.ENEMY_TURN:
		card.activate({
		"caster": $MainScreen/EnemyCharacter,
		"your_monster":enemy_deck_in_hand.table.table,
		"targets": player_deck_in_hand.table.table,
		"enemy": $MainScreen/PlayerCharacter
	})

func _on_deck_in_hand_card_activated(card: UsableCard) -> void:
	var card_cost: int = card.get_cost()
	if game_control.current_state == GameController.TurnState.PLAYER_TURN:
		if card_cost <= $MainScreen/PlayerCharacter.health:
			card.activate({
			"caster": $MainScreen/PlayerCharacter,
			"your_monster":player_deck_in_hand.table.table,
			"targets": enemy_deck_in_hand.table.table,
			"enemy": $MainScreen/EnemyCharacter
			})
	elif game_control.current_state == GameController.TurnState.ENEMY_TURN:
		if card_cost <= $MainScreen/EnemyCharacter.health:
			card.activate({
			"caster": $MainScreen/EnemyCharacter,
			"your_monster":enemy_deck_in_hand.table.table,
			"targets": player_deck_in_hand.table.table,
			"enemy": $MainScreen/PlayerCharacter
			})

#func _on_enemy_table_card_activated(card: UsableCard) -> void:
#	var card_cost: int = card.get_cost()
#	if game_control.current_state == GameController.TurnState.ENEMY_TURN:
#		card.activate({
#		"caster": $MainScreen/EnemyCharacter,
#		"targets": $MainScreen/PlayerCharacter
#	})

#func _on_enemy_deck_in_hand_card_activated(card: UsableCard) -> void:
#	var card_cost: int = card.get_cost()
#	if game_control.current_state == GameController.TurnState.ENEMY_TURN:
#		card.activate({
#			"caster": $MainScreen/EnemyCharacter,
#			"targets": $MainScreen/PlayerCharacter
#		})
#		card.queue_free()

func _on_inflict_1_damage_pressed() -> void:
	player_character.take_damage(1)

func _on_inflict_3_damage_pressed() -> void:
	player_character.take_damage(3)

func _on_end_turn_pressed() -> void:
	if game_control.current_state == GameController.TurnState.PLAYER_TURN:
		game_control.transition(GameController.TurnState.ENEMY_TURN)
		if enemy_playable_deck != null and !enemy_playable_deck.is_empty():
			var card_with_id = enemy_playable_deck.draw_card()
			enemy_deck_in_hand.add_card(card_with_id)
		$MainScreen/EnemyCharacter.start_turn()

func _on_playable_deck_ui_pressed() -> void:
	if(!deck_ui.is_empty()):
		var card_with_id = deck_ui.draw()
		player_deck_in_hand.add_card(card_with_id)
	pass

func _on_começar_pressed() -> void:
	player_character.set_health_value(player_character.health)
	enemy_character.set_health_value(enemy_character.health)
	$"CanvasLayer/tela de começo".visible = false
	player_deck_in_hand.start()
	for i in range(5):
		var card_with_id = deck_ui.draw()
		player_deck_in_hand.add_card(card_with_id)
	enemy_deck_in_hand.start()
	for i in range(5):
		var card_with_id = deck_ui.draw()
		enemy_deck_in_hand.add_card(card_with_id)

func _on_deck_in_hand_starting() -> void:
	deck_ui.deck = player_deck.get_playable_deck()
	for i in range(5):
		var card_with_id = deck_ui.draw()
		player_deck_in_hand.add_card(card_with_id)
	enemy_playable_deck = enemy_deck.get_playable_deck()
	for i in range(5):
		var card_with_id = enemy_playable_deck.draw_card()
		enemy_deck_in_hand.add_card(card_with_id)

func _on_player_character_add_discard(type) -> void:
	if(type == "add"):
		if(!deck_ui.is_empty()):
			var card_with_id = deck_ui.draw()
			player_deck_in_hand.add_card(card_with_id)
	else:
		player_deck_in_hand.removeRandomCard()

func _on_start_button_pressed() -> void:
	$"CanvasLayer/StartScreen".visible = false
	$EnemyDeckInHand/Hand.visible = false
	var saved := PlayerDeck.load_saved()
	if not GameState.use_random_deck and saved != null and saved.is_valid():
		player_deck_in_hand.start_with_deck(saved)
	else:
		player_deck_in_hand.start()
	enemy_deck_in_hand.start()
	_on_deck_in_hand_starting()

func _on_player_deck_in_hand_objective(objective_type_card) -> void:
	objective = objective_type_card.type
	objective_card = objective_type_card
	amount_objective = 0
