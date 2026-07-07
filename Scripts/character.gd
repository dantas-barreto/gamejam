@tool
class_name Character extends Node2D

# TODO: rename add_discard — it handles both draw and discard, the name doesn't reflect that
signal add_discard

@export var starting_health: int = 50
@export var starting_armor: int = 0

var health = 50
var armor = 0

@onready var health_label: Label = $Sprite2D/HealthLabel
@onready var armor_label: Label = $ArmorLabel

func set_health_value(_health: int):
	health = _health
	update_health_value()

func update_health_value():
	if health_label.get_text() != str(health):
		health_label.set_text(str(health))

func update_armor_value():
	if armor > 0:
		armor_label.visible = true
		armor_label.set_text(str(armor)) 
	else:
		armor_label.visible = false

func add_armor(amount: int):
	armor += amount
	
func spend_health(amount: int):
	health -= amount

func take_damage(amount: int):
	var damage = 0
	damage = max(amount - armor, 0)
	if armor > 0:
		armor = armor - amount
	health -= damage

func add_health(amount: int):
	health += amount

func add_card_from_deck(amount: int):
	for i in range(amount):
		var type = "add"
		add_discard.emit(type)

func dont_attack():
	pass

func discard_random_card():
	var type = "discard"
	add_discard.emit(type)

func start_turn():
	armor = 0

func reset():
	health = starting_health
	armor = starting_armor

func _ready() -> void:
	reset()

# TODO: make update_health_value and update_armor_value event-driven (call on stat change) like card.gd
func _process(delta: float) -> void:
	update_health_value()
	update_armor_value()
