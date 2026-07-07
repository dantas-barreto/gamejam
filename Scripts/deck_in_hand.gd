extends Node2D

signal card_activated(card: UsableCard)
signal table_card_activated(card: UsableCard)
signal starting
signal objective

@export var deck: Deck

# debug
@onready var attackCardScene: PackedScene = preload("res://Scenes/Cards/Debug/ObjectiveCard.tscn")
#@onready var revivifyCardScene: PackedScene = preload("res://Scenes/Cards/Debug/RevivifyCard.tscn")
#@onready var defendCardScene: PackedScene = preload("res://Scenes/Cards/Debug/DefendCard.tscn")

# Spells
@onready var fireballCardScene: PackedScene = preload("res://Scenes/Cards/Spells/Fireball.tscn")
@onready var magicRainCardScene: PackedScene = preload("res://Scenes/Cards/Spells/MagicRain.tscn")
@onready var newWindsCardScene: PackedScene = preload("res://Scenes/Cards/Spells/NewWinds.tscn")
@onready var onFireCardScene: PackedScene = preload("res://Scenes/Cards/Spells/OnFire.tscn")
@onready var rageCardScene: PackedScene = preload("res://Scenes/Cards/Spells/Rage.tscn")
@onready var revitalizeCardScene: PackedScene = preload("res://Scenes/Cards/Spells/Revitalize.tscn")
@onready var stoneSkinCardScene: PackedScene = preload("res://Scenes/Cards/Spells/StoneSkin.tscn")
@onready var strongWindsCardScene: PackedScene = preload("res://Scenes/Cards/Spells/StrongWind.tscn")
@onready var waterOfLifeCardScene: PackedScene = preload("res://Scenes/Cards/Spells/WaterOfLife.tscn")
@onready var windBarrierCardScene: PackedScene = preload("res://Scenes/Cards/Spells/WindBarrier.tscn")

# Structures
@onready var flameTowerCardScene: PackedScene = preload("res://Scenes/Cards/Structures/FlameTower.tscn")
@onready var earthSoulCardScene: PackedScene = preload("res://Scenes/Cards/Structures/EarthSoul.tscn")
@onready var flameFortressCardScene: PackedScene = preload("res://Scenes/Cards/Structures/FlameFortress.tscn")
@onready var fortressCardScene: PackedScene = preload("res://Scenes/Cards/Structures/Fortress.tscn")
@onready var fountainOfLifeCardScene: PackedScene = preload("res://Scenes/Cards/Structures/FountainOfLife.tscn")
@onready var healthStoneCardScene: PackedScene = preload("res://Scenes/Cards/Structures/HealthStone.tscn")
@onready var mausoleumCardScene: PackedScene = preload("res://Scenes/Cards/Structures/Mausoleum.tscn")
@onready var swirlCardScene: PackedScene = preload("res://Scenes/Cards/Structures/Swirl.tscn")
@onready var waterMarkCardScene: PackedScene = preload("res://Scenes/Cards/Structures/WaterMark.tscn")

# Creatures
@onready var airGolemScene: PackedScene = preload("res://Scenes/Cards/Creatures/AirGolem.tscn")
@onready var armouredFireScene: PackedScene = preload("res://Scenes/Cards/Creatures/ArmouredFire.tscn")
@onready var dropletScene: PackedScene = preload("res://Scenes/Cards/Creatures/Droplet.tscn")
@onready var earthElementalScene: PackedScene = preload("res://Scenes/Cards/Creatures/EarthElemental.tscn")
@onready var earthGolemScene: PackedScene = preload("res://Scenes/Cards/Creatures/EarthGolem.tscn")
@onready var fireElementalScene: PackedScene = preload("res://Scenes/Cards/Creatures/FireElemental.tscn")
@onready var magicFireScene: PackedScene = preload("res://Scenes/Cards/Creatures/MagicFire.tscn")
@onready var stoneScene: PackedScene = preload("res://Scenes/Cards/Creatures/Stone.tscn")
@onready var twisterScene: PackedScene = preload("res://Scenes/Cards/Creatures/Twister.tscn")
@onready var waterElementalScene: PackedScene = preload("res://Scenes/Cards/Creatures/WaterElemental.tscn")
@onready var windElementalScene: PackedScene = preload("res://Scenes/Cards/Creatures/WindElemental.tscn")
@onready var windFairyScene: PackedScene = preload("res://Scenes/Cards/Creatures/WindFairy.tscn")


@onready var table: Table = $Table
@onready var hand: Hand = $Hand

func _ready(): 
	pass

func _process(delta):
	pass

func add_card(card_with_id: CardWithID):
	hand.add_card(card_with_id.card)

func reset():
	hand.empty_hand()

func remove_random_card():
	hand.remove_card(randi_range(0,hand.hand.size()-1))

func start_with_deck(player_deck_data: PlayerDeck) -> void:
	for card_id in player_deck_data.card_ids:
		var scene := CardRegistry.get_scene(card_id)
		if scene:
			deck.add_card(scene.instantiate())

# TODO: drive random deck from CardRegistry.get_all() instead of hardcoded scene preloads
func start():
	# 1x spells
	deck.add_card(newWindsCardScene.instantiate())
	deck.add_card(onFireCardScene.instantiate())
	deck.add_card(revitalizeCardScene.instantiate())
	deck.add_card(stoneSkinCardScene.instantiate())
	deck.add_card(strongWindsCardScene.instantiate())
	deck.add_card(waterOfLifeCardScene.instantiate())
	deck.add_card(windBarrierCardScene.instantiate())

	# 1x structures
	deck.add_card(flameTowerCardScene.instantiate())
	deck.add_card(flameFortressCardScene.instantiate())
	deck.add_card(fortressCardScene.instantiate())
	deck.add_card(swirlCardScene.instantiate())
	deck.add_card(mausoleumCardScene.instantiate())
	deck.add_card(waterMarkCardScene.instantiate())

	# 1x creatures
	deck.add_card(earthElementalScene.instantiate())
	deck.add_card(fireElementalScene.instantiate())
	deck.add_card(waterElementalScene.instantiate())
	deck.add_card(windElementalScene.instantiate())

	# 3x each
	for i in range(3):
		deck.add_card(fireballCardScene.instantiate())
		deck.add_card(magicRainCardScene.instantiate())
		deck.add_card(rageCardScene.instantiate())

		deck.add_card(earthSoulCardScene.instantiate())
		deck.add_card(fountainOfLifeCardScene.instantiate())
		deck.add_card(healthStoneCardScene.instantiate())

		deck.add_card(airGolemScene.instantiate())
		deck.add_card(armouredFireScene.instantiate())
		deck.add_card(dropletScene.instantiate())
		deck.add_card(earthGolemScene.instantiate())
		deck.add_card(magicFireScene.instantiate())
		deck.add_card(stoneScene.instantiate())
		deck.add_card(twisterScene.instantiate())
		deck.add_card(windFairyScene.instantiate())


func _on_attack_pressed():
	var attackCard = attackCardScene.instantiate()
	objective.emit(attackCard)

#func _on_revivify_pressed():
#	var revivifyCard = revivifyCardScene.instantiate()
#	deck.add_card(revivifyCard)

#func _on_defend_pressed() -> void:
#	var defendCard = defendCardScene.instantiate()
#	deck.add_card(defendCard)

func _on_hand_card_transfer_to_table(card: UsableCard) -> void:
	hand.remove_card(hand.hand.find(card))
	card_activated.emit(card)
	if(card.get_type() == "creature"):
		table.add_card(card)
	elif(card.get_type() == "structure"):
		table.add_structure(card)

func _on_table_card_activated(card: UsableCard) -> void:
	card_activated.emit(card)
