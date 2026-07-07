class_name PlayerDeck extends Resource

const MAX_CARDS := 40
const SAVE_PATH := "user://deck.tres"

@export var card_ids: Array[String] = []

func add_card(id: String) -> bool:
	if card_ids.size() >= MAX_CARDS:
		return false
	card_ids.append(id)
	return true

func remove_card(id: String) -> bool:
	var idx := card_ids.rfind(id)
	if idx == -1:
		return false
	card_ids.remove_at(idx)
	return true

func count_of(id: String) -> int:
	var n := 0
	for c in card_ids:
		if c == id:
			n += 1
	return n

func is_valid() -> bool:
	return card_ids.size() > 0

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)

static func load_saved() -> PlayerDeck:
	if ResourceLoader.exists(SAVE_PATH):
		return ResourceLoader.load(SAVE_PATH) as PlayerDeck
	return null
