extends Control

var selected_monster_index = 0
var total_enemies = 6
var new_poten_input = 0
var former_poten_input = 0

@export var panel_list: Array[Panel]
var gray = Color(.5, .5, .5, .8)
var dark_gray = Color(.25, .25, .25, .5)
var white = Color(1.0, 1.0, 1.0, 1.0)
var monster_list = []
var monster_sprites = []
@onready var description = $Description
var battle_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	populate_monster_list()
	update_selected_monster()
	shade_enemies()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if (event.is_action_pressed("right_button")):
		select_monster()
		get_viewport().set_input_as_handled()
	
	if(event.is_action_pressed("0_key_push")):
		selected_monster_index = 0
		update_selected_monster()
	elif (event.is_action_pressed("1_key_push")):
		selected_monster_index = 1
		update_selected_monster()
	elif (event.is_action_pressed("2_key_push")):
		selected_monster_index = 2
		update_selected_monster()
	elif (event.is_action_pressed("3_key_push")):
		selected_monster_index = 3
		update_selected_monster()
	elif (event.is_action_pressed("4_key_push")):
		selected_monster_index = 4
		update_selected_monster()
	elif (event.is_action_pressed("5_key_push")):
		selected_monster_index = 5
		update_selected_monster()


func populate_monster_list():
	var i = 0
	var instance
	for monster in GameManager.pals_inventory:
		instance = monster.instantiate()
		panel_list[i].add_child(instance)
		monster_list.append(instance)
		monster_sprites.append(instance.find_child("Sprite2D"))
		i += 1


func select_monster():
	battle_menu.add_player_monster(monster_list[selected_monster_index])


func update_selected_monster():
	shade_enemies()
	update_description()


func update_description():
	description.text = monster_list[selected_monster_index].description


func shade_enemies():
	var i = 0
	for sprite in monster_sprites:
		i += 1
		sprite.modulate = gray
		if i > GameManager.num_of_unlocked_enemies:
			sprite.modulate = dark_gray
	monster_sprites[selected_monster_index].modulate = white
