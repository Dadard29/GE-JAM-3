extends Node2D

var level_scene
onready var player_scene
onready var player_mirror_scene

var Y_OFFSET = 500
var X_OFFSET = 0

var base_path = "res://scenes/levels/"
var _levels = [
	base_path + "Level1.tscn",
	base_path + "Level2.tscn",
]

var current_level = 0

# just loads the nodes, level to be loaded manually
func _ready():
	load_level()
	
	
func _load_player():
	player_scene = get_node("Player")
	player_scene.set_position(Vector2(X_OFFSET, -Y_OFFSET))
	player_scene.activate()
	player_scene.visible = true
	
	player_mirror_scene = get_node("PlayerMirror")
	player_mirror_scene.set_position(Vector2(X_OFFSET, Y_OFFSET))
	player_mirror_scene.activate()
	player_mirror_scene.visible = true
	
	
func _clear_player():
	player_scene.deactivate()
	player_scene.visible = false

	player_mirror_scene.deactivate()
	player_mirror_scene.visible = false

func load_level():
	var level_path = _levels[current_level]
	var level_packed: PackedScene = load(level_path)
	level_scene = level_packed.instance()
	add_child(level_scene)
	
	_load_player()
	
func next_level():
	current_level += 1
	if current_level >= len(_levels):
		print("win")
		Global.load_win()

	else:
		clear_level()
		load_level()

func clear_level():
	remove_child(level_scene)
	_clear_player()

func on_jumping():
	level_scene.show_mask()

func on_landing():
	level_scene.hide_mask()

func on_die():
	Global.load_popup()


func _on_Pill_body_entered(body):
	next_level()
