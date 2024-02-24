extends Control

signal start_gacha

var selected_button_index = 1
var total_main_menu_buttons = 2
var new_poten_input = 1
var former_poten_input

@onready var highlight_effect = $highlight_button


func _ready():
	#initialize highlight effect
	update_highlight_position()
	
	former_poten_input = new_poten_input


func _input(event):
	
	if(event.is_action_pressed("0_key_push")):
		new_poten_input = 0
	elif (event.is_action_pressed("1_key_push")):
		new_poten_input = 1
	elif (event.is_action_pressed("2_key_push")):
		new_poten_input = 2
	elif (event.is_action_pressed("3_key_push")):
		new_poten_input = 3
	elif (event.is_action_pressed("4_key_push")):
		new_poten_input = 4
		
	if(new_poten_input > former_poten_input):
		selected_button_index = (selected_button_index + 1) % total_main_menu_buttons
		former_poten_input = new_poten_input
		update_highlight_position()
	elif (new_poten_input < former_poten_input):
		selected_button_index = (selected_button_index - 1) % total_main_menu_buttons
		former_poten_input = new_poten_input
		update_highlight_position()
	
	# Button: Accept / Confirm
	elif (event.is_action_pressed("right_button")):
		press_selected_button(selected_button_index)
		
		# DEBUG: Gain more coins
	elif(event.is_action_pressed("ui_accept")):
		GameManager.total_coins += 1
		print("Total Coins: " + str(GameManager.total_coins))


func update_highlight_position():
	var selected_button = get_node("Buttons").get_child(selected_button_index)
	highlight_effect.global_position = selected_button.global_position


func press_selected_button(index):
	match  index:
		0:
			_on_back_button_pressed()
		1:
			_on_roll_button_pressed()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main Menu.tscn")

func _on_roll_button_pressed():
	emit_signal("start_gacha")
