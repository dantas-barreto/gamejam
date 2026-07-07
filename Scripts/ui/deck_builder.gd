extends Control

@onready var grid: GridContainer = $MarginContainer/VBoxContainer/ContentHBox/ScrollContainer/GridContainer
@onready var count_label: Label = $MarginContainer/VBoxContainer/Header/CountLabel
@onready var preview_art: TextureRect = $MarginContainer/VBoxContainer/ContentHBox/PreviewPanel/PreviewMargin/PreviewVBox/PreviewArt
@onready var preview_name: Label = $MarginContainer/VBoxContainer/ContentHBox/PreviewPanel/PreviewMargin/PreviewVBox/PreviewName
@onready var preview_stats: Label = $MarginContainer/VBoxContainer/ContentHBox/PreviewPanel/PreviewMargin/PreviewVBox/PreviewStats
@onready var preview_title: Label = $MarginContainer/VBoxContainer/ContentHBox/PreviewPanel/PreviewMargin/PreviewVBox/PreviewTitle

var deck: PlayerDeck = PlayerDeck.new()

func _ready() -> void:
	var saved := PlayerDeck.load_saved()
	if saved != null:
		deck = saved
	_build_grid()
	_refresh_all_slots()
	_update_count()

func _build_grid() -> void:
	for card_id in CardRegistry.get_all():
		var info := CardRegistry.get_info(card_id)
		grid.add_child(_make_slot(card_id, info))

func _make_slot(card_id: String, info: Dictionary) -> Button:
	var btn := Button.new()
	btn.name = card_id
	btn.custom_minimum_size = Vector2(140, 185)
	btn.clip_contents = true
	btn.gui_input.connect(_on_slot_input.bind(card_id))
	btn.mouse_entered.connect(_show_preview.bind(card_id))
	btn.mouse_exited.connect(_clear_preview)

	var vbox := VBoxContainer.new()
	vbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	btn.add_child(vbox)

	var art := TextureRect.new()
	art.texture = load(info["texture"])
	art.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	art.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	art.size_flags_vertical = Control.SIZE_EXPAND_FILL
	vbox.add_child(art)

	var name_lbl := Label.new()
	name_lbl.text = info["name"]
	name_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	name_lbl.add_theme_font_size_override("font_size", 10)
	name_lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	vbox.add_child(name_lbl)

	var stats_lbl := Label.new()
	stats_lbl.text = _stat_text(info)
	stats_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	stats_lbl.add_theme_font_size_override("font_size", 9)
	vbox.add_child(stats_lbl)

	var count_badge := Label.new()
	count_badge.name = "CountBadge"
	count_badge.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	count_badge.add_theme_font_size_override("font_size", 11)
	count_badge.add_theme_color_override("font_color", Color.YELLOW)
	vbox.add_child(count_badge)

	return btn

func _show_preview(card_id: String) -> void:
	var info := CardRegistry.get_info(card_id)
	preview_title.visible = false
	preview_art.texture = load(info["texture"])
	preview_name.text = info["name"]
	preview_stats.text = _stat_text(info)

func _clear_preview() -> void:
	preview_title.visible = true
	preview_art.texture = null
	preview_name.text = ""
	preview_stats.text = ""

func _stat_text(info: Dictionary) -> String:
	var t: String = info["type"]
	var c: int = info.get("cost", 1)
	if t == "creature":
		return "%s  Cost:%d  %d/%d" % [t, c, info.get("attack", 0), info.get("defense", 0)]
	elif t == "structure":
		return "%s  Cost:%d  Def:%d" % [t, c, info.get("defense", 0)]
	return "%s  Cost:%d" % [t, c]

func _on_slot_input(event: InputEvent, card_id: String) -> void:
	if not (event is InputEventMouseButton and event.pressed):
		return
	if event.button_index == MOUSE_BUTTON_LEFT:
		deck.add_card(card_id)
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		deck.remove_card(card_id)
	_refresh_slot(card_id)
	_update_count()

func _refresh_slot(card_id: String) -> void:
	var slot := grid.get_node_or_null(card_id)
	if slot == null:
		return
	var badge: Label = slot.get_node_or_null("VBoxContainer/CountBadge")
	if badge == null:
		return
	var n := deck.count_of(card_id)
	badge.text = "x%d" % n if n > 0 else ""

func _refresh_all_slots() -> void:
	for card_id in CardRegistry.get_all():
		_refresh_slot(card_id)

func _update_count() -> void:
	count_label.text = "%d / %d" % [deck.card_ids.size(), PlayerDeck.MAX_CARDS]

func _on_save_pressed() -> void:
	deck.save()
	get_tree().change_scene_to_file("res://Scenes/ui/StartMenu.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/ui/StartMenu.tscn")
