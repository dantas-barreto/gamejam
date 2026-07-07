extends Node

const CARDS: Dictionary = {
	"air_golem": {
		"name": "Air Golem", "type": "creature", "cost": 3, "attack": 4, "defense": 2,
		"scene": "res://Scenes/Cards/Creatures/AirGolem.tscn",
		"texture": "res://Sprites/cards/air/golem_de_ar.jpg"
	},
	"armoured_fire": {
		"name": "Armoured Fire", "type": "creature", "cost": 1, "attack": 1, "defense": 2,
		"scene": "res://Scenes/Cards/Creatures/ArmouredFire.tscn",
		"texture": "res://Sprites/cards/fire/fogo_armadurado.jpg"
	},
	"droplet": {
		"name": "Droplet", "type": "creature", "cost": 1, "attack": 1, "defense": 1,
		"scene": "res://Scenes/Cards/Creatures/Droplet.tscn",
		"texture": "res://Sprites/cards/water/gota.jpg"
	},
	"earth_elemental": {
		"name": "Earth Elemental", "type": "creature", "cost": 10, "attack": 11, "defense": 14,
		"scene": "res://Scenes/Cards/Creatures/EarthElemental.tscn",
		"texture": "res://Sprites/cards/earth/elemental_de_terra.jpg"
	},
	"earth_golem": {
		"name": "Earth Golem", "type": "creature", "cost": 3, "attack": 3, "defense": 3,
		"scene": "res://Scenes/Cards/Creatures/EarthGolem.tscn",
		"texture": "res://Sprites/cards/earth/golem_de_terra.jpg"
	},
	"fire_elemental": {
		"name": "Fire Elemental", "type": "creature", "cost": 10, "attack": 4, "defense": 7,
		"scene": "res://Scenes/Cards/Creatures/FireElemental.tscn",
		"texture": "res://Sprites/cards/fire/elemental_de_fogo.jpg"
	},
	"magic_fire": {
		"name": "Magic Fire", "type": "creature", "cost": 1, "attack": 1, "defense": 1,
		"scene": "res://Scenes/Cards/Creatures/MagicFire.tscn",
		"texture": "res://Sprites/cards/fire/fogo_magico.jpg"
	},
	"stone": {
		"name": "Stone", "type": "creature", "cost": 1, "attack": 0, "defense": 3,
		"scene": "res://Scenes/Cards/Creatures/Stone.tscn",
		"texture": "res://Sprites/cards/earth/pedregulho.jpg"
	},
	"twister": {
		"name": "Twister", "type": "creature", "cost": 5, "attack": 5, "defense": 3,
		"scene": "res://Scenes/Cards/Creatures/Twister.tscn",
		"texture": "res://Sprites/cards/air/tornado.jpg"
	},
	"water_elemental": {
		"name": "Water Elemental", "type": "creature", "cost": 10, "attack": 8, "defense": 10,
		"scene": "res://Scenes/Cards/Creatures/WaterElemental.tscn",
		"texture": "res://Sprites/cards/water/elemental_de_agua.jpg"
	},
	"wind_elemental": {
		"name": "Wind Elemental", "type": "creature", "cost": 10, "attack": 15, "defense": 9,
		"scene": "res://Scenes/Cards/Creatures/WindElemental.tscn",
		"texture": "res://Sprites/cards/air/elemental_de_vento.jpg"
	},
	"wind_fairy": {
		"name": "Wind Fairy", "type": "creature", "cost": 1, "attack": 1, "defense": 1,
		"scene": "res://Scenes/Cards/Creatures/WindFairy.tscn",
		"texture": "res://Sprites/cards/air/fadas_de_vento.jpg"
	},
	"fireball": {
		"name": "Fireball", "type": "spell", "cost": 3, "attack": 0, "defense": 0,
		"scene": "res://Scenes/Cards/Spells/Fireball.tscn",
		"texture": "res://Sprites/cards/fire/fireball.jpg"
	},
	"magic_rain": {
		"name": "Magic Rain", "type": "spell", "cost": 2, "attack": 0, "defense": 0,
		"scene": "res://Scenes/Cards/Spells/MagicRain.tscn",
		"texture": "res://Sprites/cards/water/chuva_magica.jpg"
	},
	"new_winds": {
		"name": "New Winds", "type": "spell", "cost": 4, "attack": 0, "defense": 0,
		"scene": "res://Scenes/Cards/Spells/NewWinds.tscn",
		"texture": "res://Sprites/cards/air/novos_ares.jpg"
	},
	"on_fire": {
		"name": "On Fire", "type": "spell", "cost": 2, "attack": 0, "defense": 0,
		"scene": "res://Scenes/Cards/Spells/OnFire.tscn",
		"texture": "res://Sprites/cards/fire/em_chamas.jpg"
	},
	"rage": {
		"name": "Rage", "type": "spell", "cost": 2, "attack": 0, "defense": 0,
		"scene": "res://Scenes/Cards/Spells/Rage.tscn",
		"texture": "res://Sprites/cards/fire/enfurecer.jpg"
	},
	"revitalize": {
		"name": "Revitalize", "type": "spell", "cost": 2, "attack": 0, "defense": 0,
		"scene": "res://Scenes/Cards/Spells/Revitalize.tscn",
		"texture": "res://Sprites/cards/water/revitalizar.jpg"
	},
	"stone_skin": {
		"name": "Stone Skin", "type": "spell", "cost": 2, "attack": 0, "defense": 0,
		"scene": "res://Scenes/Cards/Spells/StoneSkin.tscn",
		"texture": "res://Sprites/cards/earth/endurecer.jpg"
	},
	"strong_wind": {
		"name": "Strong Winds", "type": "spell", "cost": 2, "attack": 0, "defense": 0,
		"scene": "res://Scenes/Cards/Spells/StrongWind.tscn",
		"texture": "res://Sprites/cards/air/ventos_fortes.jpg"
	},
	"water_of_life": {
		"name": "Water of Life", "type": "spell", "cost": 5, "attack": 0, "defense": 0,
		"scene": "res://Scenes/Cards/Spells/WaterOfLife.tscn",
		"texture": "res://Sprites/cards/water/agua_da_vida.jpg"
	},
	"wind_barrier": {
		"name": "Wind Barrier", "type": "spell", "cost": 2, "attack": 0, "defense": 0,
		"scene": "res://Scenes/Cards/Spells/WindBarrier.tscn",
		"texture": "res://Sprites/cards/air/barreira_de_vento.jpg"
	},
	"earth_soul": {
		"name": "Earth Soul", "type": "structure", "cost": 2, "attack": 0, "defense": 2,
		"scene": "res://Scenes/Cards/Structures/EarthSoul.tscn",
		"texture": "res://Sprites/cards/earth/alma_da_terra.jpg"
	},
	"flame_fortress": {
		"name": "Flame Fortress", "type": "structure", "cost": 3, "attack": 0, "defense": 1,
		"scene": "res://Scenes/Cards/Structures/FlameFortress.tscn",
		"texture": "res://Sprites/cards/fire/fortaleza_de_chamas.jpg"
	},
	"flame_tower": {
		"name": "Flame Tower", "type": "structure", "cost": 4, "attack": 0, "defense": 4,
		"scene": "res://Scenes/Cards/Structures/FlameTower.tscn",
		"texture": "res://Sprites/cards/fire/torre_de_fogo.jpg"
	},
	"fortress": {
		"name": "Fortress", "type": "structure", "cost": 4, "attack": 0, "defense": 8,
		"scene": "res://Scenes/Cards/Structures/Fortress.tscn",
		"texture": "res://Sprites/cards/earth/fortaleza.jpg"
	},
	"fountain_of_life": {
		"name": "Fountain Of Life", "type": "structure", "cost": 5, "attack": 0, "defense": 5,
		"scene": "res://Scenes/Cards/Structures/FountainOfLife.tscn",
		"texture": "res://Sprites/cards/water/fonte_da_vida.jpg"
	},
	"health_stone": {
		"name": "Health Stone", "type": "structure", "cost": 2, "attack": 0, "defense": 2,
		"scene": "res://Scenes/Cards/Structures/HealthStone.tscn",
		"texture": "res://Sprites/cards/earth/pedra_de_mana.jpg"
	},
	"mausoleum": {
		"name": "Mausoleum", "type": "structure", "cost": 7, "attack": 0, "defense": 2,
		"scene": "res://Scenes/Cards/Structures/Mausoleum.tscn",
		"texture": "res://Sprites/cards/earth/mausoleu_de_mana.jpg"
	},
	"swirl": {
		"name": "Swirl", "type": "structure", "cost": 2, "attack": 0, "defense": 2,
		"scene": "res://Scenes/Cards/Structures/Swirl.tscn",
		"texture": "res://Sprites/cards/water/redemoinho.jpg"
	},
	"water_mark": {
		"name": "Water Mark", "type": "structure", "cost": 2, "attack": 0, "defense": 1,
		"scene": "res://Scenes/Cards/Structures/WaterMark.tscn",
		"texture": "res://Sprites/cards/water/marca_da_agua.jpg"
	},
}

func get_scene(card_id: String) -> PackedScene:
	if not CARDS.has(card_id):
		push_error("CardRegistry: unknown card id '%s'" % card_id)
		return null
	return load(CARDS[card_id]["scene"])

func get_info(card_id: String) -> Dictionary:
	return CARDS.get(card_id, {})

func get_all() -> Dictionary:
	return CARDS
