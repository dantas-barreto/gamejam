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
@onready var waterOfLiteCardScene: PackedScene = preload("res://Scenes/Cards/Spells/WaterOfLife.tscn")
@onready var windBarrierCardScene: PackedScene = preload("res://Scenes/Cards/Spells/WindBarrier.tscn")

# Structures
@onready var flameTowerCardScene: PackedScene = preload("res://Scenes/Cards/Structures/FlameTower.tscn")
@onready var earthSoulCardScene: PackedScene = preload("res://Scenes/Cards/Structures/EarthSoul.tscn")
@onready var flameFortressCardScene: PackedScene = preload("res://Scenes/Cards/Structures/FlameFortress.tscn")
@onready var fortressCardScene: PackedScene = preload("res://Scenes/Cards/Structures/Fortress.tscn")
@onready var fountainOdLifeCardScene: PackedScene = preload("res://Scenes/Cards/Structures/FountainOfLife.tscn")
@onready var healthStoneCardScene: PackedScene = preload("res://Scenes/Cards/Structures/HealthStone.tscn")
@onready var mausoleumCardScene: PackedScene = preload("res://Scenes/Cards/Structures/Mausoleum.tscn")
@onready var swirlCardScene: PackedScene = preload("res://Scenes/Cards/Structures/Swirl.tscn")
@onready var waterMarkCardScene: PackedScene = preload("res://Scenes/Cards/Structures/WaterMark.tscn")

# Creatures
@onready var airGolemScene: PackedScene = preload("res://Scenes/Cards/Creatures/AirGolem.tscn")
@onready var armouredfireScene: PackedScene = preload("res://Scenes/Cards/Creatures/ArmouredFire.tscn")
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

func removeRandomCard():
	hand.remove_card(randi_range(0,hand.hand.size()-1))

func start_with_deck(player_deck_data: PlayerDeck) -> void:
	for card_id in player_deck_data.card_ids:
		var scene := CardRegistry.get_scene(card_id)
		if scene:
			deck.add_card(scene.instantiate())

func start():
	#spells
	var fireball = fireballCardScene.instantiate()
	var magicRain = magicRainCardScene.instantiate()
	var newWinds = newWindsCardScene.instantiate()
	var onFire = onFireCardScene.instantiate()
	var rage = rageCardScene.instantiate()
	var revitalize = revitalizeCardScene.instantiate()
	var stoneSkin = stoneSkinCardScene.instantiate()
	var strongWinds = strongWindsCardScene.instantiate()
	var waterOfLife = waterOfLiteCardScene.instantiate()
	var windBarrier = windBarrierCardScene.instantiate()
	deck.add_card(newWinds)
	deck.add_card(onFire)
	deck.add_card(revitalize)
	deck.add_card(stoneSkin)
	deck.add_card(strongWinds)
	deck.add_card(waterOfLife)
	deck.add_card(windBarrier)
	
	#Structures
	var flameTower = flameTowerCardScene.instantiate()
	var earthSoul = earthSoulCardScene.instantiate()
	var flameFortress = flameFortressCardScene.instantiate()
	var fortress = fortressCardScene.instantiate()
	var fountainOdLife = fountainOdLifeCardScene.instantiate()
	var healthStone = healthStoneCardScene.instantiate()
	var mausoleum = mausoleumCardScene.instantiate()
	var swirl = swirlCardScene.instantiate()
	var waterMark = waterMarkCardScene.instantiate()
	deck.add_card(flameTower)
	deck.add_card(flameFortress)
	deck.add_card(fortress)
	deck.add_card(swirl)
	deck.add_card(mausoleum)
	deck.add_card(waterMark)
	
	#creature
	var airGolem = airGolemScene.instantiate()
	var armouredFire = armouredfireScene.instantiate()
	var droplet = dropletScene.instantiate()
	var earthElemental = earthElementalScene.instantiate()
	var earthGolem = earthGolemScene.instantiate()
	var fireElemental = fireElementalScene.instantiate()
	var magicFire = magicFireScene.instantiate()
	var stone = stoneScene.instantiate()
	var twister = twisterScene.instantiate()
	var waterElemental = waterElementalScene.instantiate()
	var windElemental = windElementalScene.instantiate()
	var windFairy = windFairyScene.instantiate()
	deck.add_card(earthElemental)
	deck.add_card(fireElemental)
	deck.add_card(waterElemental)
	deck.add_card(windElemental)
	
	for i in range(3): 
		deck.add_card(fireball)
		deck.add_card(magicRain)
		deck.add_card(rage)
		
		deck.add_card(earthSoul)
		deck.add_card(fountainOdLife)
		deck.add_card(healthStone)
		
		deck.add_card(airGolem)
		deck.add_card(armouredFire)
		deck.add_card(droplet)
		deck.add_card(earthGolem)
		deck.add_card(magicFire)
		deck.add_card(stone)
		deck.add_card(twister)
		deck.add_card(windFairy)


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
