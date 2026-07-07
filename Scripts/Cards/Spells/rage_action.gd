extends Node2D

func activate(game_state: Dictionary):
	var caster: Character = game_state.get("caster")
	caster.spend_health(2)
	game_state.get("enemy").take_damage(1)
	caster.add_card_from_deck(3)
	caster.discard_random_card()
