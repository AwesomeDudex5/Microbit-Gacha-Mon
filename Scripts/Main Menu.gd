extends Control

var selected_button_index = 0
var total_main_menu_buttons = 3
var new_poten_input = 0
var former_poten_input
@export var blue = Color(0, 0, 0, 1.0)

func _ready():
	#initialize highlight effect
	update_highlight_position()
	
	former_poten_input = new_poten_input


func _input(event):
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
	
	if num == 0 or num == 1:
		selected_button_index = 0
	elif num == 2 or num == 3:
		selected_button_index = 1
	elif num == 4 or num == 5:
		selected_button_index = 2
	
	if (event.is_action_pressed("ui_next")):
		selected_button_index += 1
		if selected_button_index > total_main_menu_buttons - 1:
			selected_button_index = 0
		update_highlight_position()
	if (event.is_action_pressed("ui_prev")):
		selected_button_index -= 1
		if selected_button_index < 0:
			selected_button_index = total_main_menu_buttons - 1
		update_highlight_position()
	
	if num != -1:
		update_highlight_position()
	elif (event.is_action_pressed("right_button")):
		press_selected_button(selected_button_index)
	elif(event.is_action_pressed("ui_accept")):
		press_selected_button(selected_button_index)


func update_highlight_position():
	get_node("Buttons").get_child(0).modulate = Color.WHITE
	get_node("Buttons").get_child(0).get_child(0).set("theme_override_colors/font_color", Color.BLACK)
	get_node("Buttons").get_child(1).modulate = Color.WHITE
	get_node("Buttons").get_child(1).get_child(0).set("theme_override_colors/font_color", Color.BLACK)
	get_node("Buttons").get_child(2).modulate = Color.WHITE
	get_node("Buttons").get_child(2).get_child(0).set("theme_override_colors/font_color", Color.BLACK)
	var selected_button = get_node("Buttons").get_child(selected_button_index)
	#highlight_effect.global_position = selected_button.global_position
	selected_button.modulate = blue
	selected_button.get_child(0).set("theme_override_colors/font_color", blue)

func press_selected_button(index):
	match  index:
		0:
			_on_gacha_button_pressed()
		1:
			_on_battle_button_pressed()
		2:
			_on_quit_button_pressed()

func _on_gacha_button_pressed():
	if GameManager.has_all_mons():
		$"Have All Mons".visible = true
	else:
		get_tree().change_scene_to_file("res://Scenes/Gacha Menu.tscn")


func _on_battle_button_pressed():
	if GameManager.pals_inventory.size() == 0:
		$"No Mons".visible = true
	else:
		get_tree().change_scene_to_file("res://Scenes/Battle Menu.tscn")
		$"No Mons".visible = false


func _on_quit_button_pressed():
	get_tree().quit()
