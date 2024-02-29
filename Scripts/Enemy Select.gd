extends Control

var selected_enemy_index = 0
var total_enemies = 6
var new_poten_input = 0
var former_poten_input = 0

@export var panel_list: Array[Panel]
var gray = Color(.5, .5, .5, 1.0)
var dark_gray = Color(0, 0, 0, 1.0)
var white = Color(1.0, 1.0, 1.0, 1.0)
@onready var enemy_list = [
	panel_list[0].find_child("Monster"),
	panel_list[1].find_child("Monster"),
	panel_list[2].find_child("Monster"),
	panel_list[3].find_child("Monster"),
	panel_list[4].find_child("Monster"),
	panel_list[5].find_child("Monster")
]
@onready var enemy_sprites = [
	enemy_list[0].find_child("Sprite2D"),
	enemy_list[1].find_child("Sprite2D"),
	enemy_list[2].find_child("Sprite2D"),
	enemy_list[3].find_child("Sprite2D"),
	enemy_list[4].find_child("Sprite2D"),
	enemy_list[5].find_child("Sprite2D"),
]
@onready var description = $Description
var battle_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	update_selected_enemy()
	shade_enemies()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if (event.is_action_pressed("right_button")):
		select_enemy()
		get_viewport().set_input_as_handled()
	
	if(event.is_action_pressed("0_key_push")):
		edit_selected_enemy_index(0)
	elif (event.is_action_pressed("1_key_push")):
		edit_selected_enemy_index(1)
	elif (event.is_action_pressed("2_key_push")):
		edit_selected_enemy_index(2)
	elif (event.is_action_pressed("3_key_push")):
		edit_selected_enemy_index(3)
	elif (event.is_action_pressed("4_key_push")):
		edit_selected_enemy_index(4)
	elif (event.is_action_pressed("5_key_push")):
		edit_selected_enemy_index(5)


func edit_selected_enemy_index(n):
	if n < GameManager.num_of_unlocked_enemies:
		selected_enemy_index = n
		update_selected_enemy()


func select_enemy():
	battle_menu.add_enemy_monster(enemy_list[selected_enemy_index])


func update_selected_enemy():
	shade_enemies()
	update_description()


func update_description():
	description.text = enemy_list[selected_enemy_index].description


func shade_enemies():
	var i = 0
	for sprite in enemy_sprites:
		i += 1
		sprite.modulate = gray
		if i > GameManager.num_of_unlocked_enemies:
			sprite.modulate = dark_gray
	enemy_sprites[selected_enemy_index].modulate = white
