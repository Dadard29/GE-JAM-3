extends Node

var MAIN_MENU = "res://scenes/game/MainMenu.tscn"
var LEVEL = "res://scenes/game/Main.tscn"
var POPUP = "res://scenes/game/Popup.tscn"
var WIN = "res://scenes/game/Win.tcsn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_main_menu():
	get_tree().change_scene(MAIN_MENU)
	
func load_game():
	get_tree().change_scene(LEVEL)

func load_popup():
	get_tree().change_scene(POPUP)

func load_win():
	get_tree().change_scene(WIN)

func exit():
	get_tree().quit()

