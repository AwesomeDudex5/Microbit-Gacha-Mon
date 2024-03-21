extends Control

signal start_gacha

var selected_button_index = 1
var total_main_menu_buttons = 2
var new_poten_input = 1
var former_poten_input

enum Gacha_Menu_States {Gacha_Menu, Rolling_Menu}
var current_gacha_menu_state : Gacha_Menu_States = Gacha_Menu_States.Gacha_Menu
@export var blue = Color(0, 0, 0, 1.0)
@onready var gacha_system = $"Gacha System"


func _ready():
	update_highlight_position()
	var gacha_system_node = $"Gacha System"
	gacha_system_node.connect("end_gacha", reset_menu_state)
	former_poten_input = new_poten_input


func _unhandled_input(event):
	var num = -1
	if(event.is_action_pressed("0_key_push")):
		num = 0
	elif (event.is_action_pressed("1_key_push")):
		num = 1
	elif (event.is_action_pressed("2_key_push")):
		num = 2
	elif (event.is_action_pressed("3_key_push")):
		num = 3
	elif (event.is_action_pressed("4_key_push")):
		num = 4
	elif (event.is_action_pressed("5_key_push")):
		num = 5
	
	if (event.is_action_pressed("ui_next")):
		selected_button_index += 1
		if selected_button_index > total_main_menu_buttons - 1:
			selected_button_index = 0
		if GameManager.has_all_mons():
			selected_button_index = 0
		update_highlight_position()
	if (event.is_action_pressed("ui_prev")):
		selected_button_index -= 1
		if selected_button_index < 0:
			selected_button_index = total_main_menu_buttons - 1
		if GameManager.has_all_mons():
			selected_button_index = 0
		update_highlight_position()
	
	if(current_gacha_menu_state == Gacha_Menu_States.Gacha_Menu):
		if num == 0 or num == 1 or num == 2:
			selected_button_index = 0
		elif num == 3 or num == 4 or num == 5:
			selected_button_index = 1
	if(current_gacha_menu_state == Gacha_Menu_States.Gacha_Menu):
		if num != -1:
			update_highlight_position()
		# Button: Accept / Confirm
		elif (event.is_action_pressed("right_button")):
			press_selected_button(selected_button_index)
		elif(event.is_action_pressed("ui_accept")):
			press_selected_button(selected_button_index)
		elif(event.is_action_pressed("left_button") || event.is_action_pressed("ui_cancel")):
			get_viewport().set_input_as_handled()
			_on_back_button_pressed()

func reset_menu_state():
	if GameManager.has_all_mons():
		$"Gacha System/All Mons Obtained".visible = true
		$"Gacha System/Coins Available".visible = false
		$"Gacha System/Coins to Roll".visible = false
		$"Buttons/Roll Button".visible = false
	
	current_gacha_menu_state = Gacha_Menu_States.Gacha_Menu
	selected_button_index = 1
	update_highlight_position()
	$"Gacha System/Pal Sprite".texture = load("res://Sprites/UI/capsule.png")

func update_highlight_position():
	get_node("Buttons").get_child(0).modulate = Color.WHITE
	get_node("Buttons").get_child(0).get_child(0).set("theme_override_colors/font_color", Color.BLACK)
	get_node("Buttons").get_child(1).modulate = Color.WHITE
	get_node("Buttons").get_child(1).get_child(0).set("theme_override_colors/font_color", Color.BLACK)
	var selected_button = get_node("Buttons").get_child(selected_button_index)
	selected_button.modulate = blue
	selected_button.get_child(0).set("theme_override_colors/font_color", blue)


func press_selected_button(index):
	match  index:
		0:
			_on_back_button_pressed()
		1:
			_on_roll_button_pressed()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main Menu.tscn")

func _on_roll_button_pressed():
	if(GameManager.total_coins >= gacha_system.roll_cost):
		current_gacha_menu_state = Gacha_Menu_States.Rolling_Menu
		emit_signal("start_gacha")
	else:
		print("Not enough coins")
