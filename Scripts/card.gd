@tool
class_name Card extends Node2D

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)
signal die_card(card: Card)

@export var base_card_sprite: Sprite2D
@export var card_frame_sprite: Sprite2D
@export var card_name: String = "Card Name"
@export var card_description: String = "Card Description"
@export var card_cost: int = 1
@export var card_attack: int = 0
@export var card_defense: int = 0
@export var card_type: String = "spell"

@onready var cost_lbl: Label = $CardCost/CardCostLabel
@onready var name_lbl: Label = $CardName/CardNameLabel
@onready var description_lbl: Label = $CardDescription/CardDescriptionLabel
@onready var attack_lbl: Label =  $Attributes/AttackLabel
@onready var defense_lbl: Label = $Attributes/DefenseLabel
@onready var base_sprite: Sprite2D = $BaseCardSprite
@onready var frame_sprite: Sprite2D = $CardFrameSprite

func _ready():
	set_card_values(card_cost, card_name, card_description, card_attack, card_defense)
	
func set_card_values(_cost: int, _name: String, _description: String, _attack: int, _defense:int):
	card_name = _name
	card_description = _description
	card_cost = _cost
	card_attack = _attack
	card_defense = _defense
	_update_graphics()

func _update_graphics():
	if cost_lbl.get_text() != str(card_cost):
		cost_lbl.set_text(str(card_cost))
	if name_lbl.get_text() != card_name:
		name_lbl.set_text(card_name)
	if description_lbl.get_text() != card_description:
		description_lbl.set_text(card_description)
	if attack_lbl.get_text() != str(card_attack):
		attack_lbl.set_text(str(card_attack))
	if defense_lbl.get_text() != str(card_defense):
		defense_lbl.set_text(str(card_defense))

func highlight():
	base_sprite.set_modulate(Color(1, 0.5, 0.1, 1))

func unhighlight():
	base_sprite.set_modulate(Color(1,1,1,1))

func get_cost() -> int:
	return card_cost

func get_type() -> String:
	return card_type

func get_attack() -> int:
	return card_attack

func get_defense() -> int:
	return card_defense

func activate():
	pass

func add_armor(amount) -> void:
	card_defense += amount
	_update_graphics()

func take_damage(amount) -> void:
	card_defense -= amount
	_update_graphics()
	if(card_defense <= 0):
		die_card.emit(self)

func dont_attack():
	card_attack = 0
	_update_graphics()

func _on_area_2d_mouse_entered():
	mouse_entered.emit(self)

func _on_area_2d_mouse_exited():
	mouse_exited.emit(self)

func _on_area_2d_input_event(viewport, event, shape_idx):
	pass
