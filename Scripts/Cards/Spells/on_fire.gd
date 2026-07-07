extends Node2D

func activate(game_state: Dictionary):
	var caster: Character = game_state.get("caster")
	caster.spend_health(3)
	caster.add_health(1)
	game_state.get("enemy").take_damage(2)
	caster.add_card_from_deck(2)
	caster.discard_random_card()
