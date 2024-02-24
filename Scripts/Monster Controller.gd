extends Node2D

@export var move_one_label: Label
@export var move_two_label: Label
@export var move_description_label: Label
var selected_move = 1
var yellow = Color(1.0, 1.0, 0.0, 1.0)
var white = Color(1.0, 1.0, 1.0, 1.0)
@onready var current_monster = find_child("Monster")

enum {NO_MON_SELECTED, MOVE_SELECTION, PLAYER_MOVE, ENEMY_MOVE}


func _ready():
	update_selected_move()
	update_move_names()


func _input(event):
	if event.is_action_pressed("make selection"):
		execute_move(selected_move)
	if event.is_action_pressed("toggle selection"):
		change_selection()


func execute_move(move_number):
	current_monster.excecute_move(move_number)


func change_selection():
	if selected_move == 1:
		selected_move = 2
	else:
		selected_move = 1
	update_selected_move()


func update_selected_move():
	if selected_move == 1:
		move_one_label.set("theme_override_colors/font_color", yellow)
		move_two_label.set("theme_override_colors/font_color", white)
		move_description_label.text = current_monster.m1_description
	else:
		move_two_label.set("theme_override_colors/font_color", yellow)
		move_one_label.set("theme_override_colors/font_color", white)
		move_description_label.text = current_monster.m2_description


func update_move_names():
	move_one_label.text = current_monster.m1_name
	move_two_label.text = current_monster.m2_name
