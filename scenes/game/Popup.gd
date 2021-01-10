extends PanelContainer

var hightlight_theme = preload("res://assets/font/entry_highlight.tres")
var default_theme = preload("res://assets/font/entry_default.tres")
var entry_index = 0

onready var entries_nodes = $MarginContainer/HBoxContainer/VBoxContainer
onready var entries = [
	entries_nodes.get_node("Margin1/Restart"),
	entries_nodes.get_node("Margin2/MainMenu"),
]
const INDEX_MIN = 0
const INDEX_MAX = 1

func hightlight_entry():
	for e in entries:
		e.set('custom_styles/normal', default_theme)
	
	entries[entry_index].set('custom_styles/normal', hightlight_theme)
	
func _restart():
	Global.load_game()

func _main_menu():
	Global.load_main_menu()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if entry_index == 0:
			_restart()
		elif entry_index == 1:
			_main_menu()

		return
	
	if event.is_action_pressed("ui_down") and entry_index < INDEX_MAX:
		entry_index += 1
	elif event.is_action_pressed("ui_up") and entry_index > INDEX_MIN:
		entry_index -= 1
	
	hightlight_entry()
