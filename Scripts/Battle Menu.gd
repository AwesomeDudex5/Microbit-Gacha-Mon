extends Control

@export var select_enemy_packed_scene: PackedScene
var select_enemy_scene
@export var select_player_packed_scene: PackedScene
var select_player_scene
@export var combat_end_scene: PackedScene
var selected_move = 1
var yellow = Color(1.0, 1.0, 0.0, 1.0)
var white = Color(1.0, 1.0, 1.0, 1.0)
@onready var player_monster
@onready var enemy_monster
@onready var enemy_sprite
@onready var player_sprite
@onready var hurt_sfx = $HurtSFX
@onready var battle_log = $BattleLog
@onready var turn_timer = $TurnTimer
@onready var player_hp_bar = $Player/HPBar
@onready var enemy_hp_bar = $Player/HPBar
@onready var move_one_container = $"Player/Move One"
@onready var move_two_container = $"Player/Move Two"
@onready var move_one_label = $"Player/Move One/Name"
@onready var move_two_label = $"Player/Move Two/Name"
@onready var move_description = $"Player/Move Description"
@onready var move_description_label = $"Player/Move Description/Margin/Description"

var current_input = -1
var new_input

enum {
	NO_MON_SELECTED, 
	SELECTING_ENEMY, 
	SELECTING_PLAYER, 
	MOVE_SELECTION, 
	PLAYER_MOVE, 
	ENEMY_MOVE,
	WIN,
	LOSS
}
var state = NO_MON_SELECTED


func _ready():
	transition_to_selecting_enemy()


func _unhandled_input(event):
	if state != MOVE_SELECTION:
		return
	if(event.is_action_pressed("0_key_push")):
		update_input(0)
	elif (event.is_action_pressed("1_key_push")):
		update_input(1)
	elif (event.is_action_pressed("2_key_push")):
		update_input(2)
	elif (event.is_action_pressed("3_key_push")):
		update_input(3)
	elif (event.is_action_pressed("4_key_push")):
		update_input(4)
	
	if event.is_action_pressed("right_button"):
		transition_to_player_move()


func update_input(n):
	if current_input == -1:
		current_input = n
		new_input = n
	else:
		new_input = n
	if current_input != new_input:
		change_selection()
	current_input = new_input

func transition_to_player_move():
	state = PLAYER_MOVE
	execute_player_move(selected_move)
	turn_timer.start()
	move_one_container.visible = false
	move_two_container.visible = false
	move_description.visible = false


func transition_to_enemy_move():
	state = ENEMY_MOVE
	excecute_enemy_move()
	turn_timer.start()


func transition_to_select_move():
	state = MOVE_SELECTION
	$Player.visible = true
	$Enemy.visible = true
	move_one_container.visible = true
	move_two_container.visible = true
	move_description.visible = true
	update_selected_move()


func transition_to_selecting_enemy():
	state = SELECTING_ENEMY
	$Player.visible = false
	$Enemy.visible = false
	select_enemy_scene = select_enemy_packed_scene.instantiate()
	add_child(select_enemy_scene)
	select_enemy_scene.battle_menu = self


func add_enemy_monster(scene):
	scene.reparent($Enemy)
	scene.position.x = 0
	scene.position.y = 0
	enemy_monster = scene
	enemy_hp_bar = $Enemy/HPBar
	enemy_hp_bar.set_max_hp(enemy_monster.max_hp)
	enemy_sprite = $Enemy/Monster/Sprite2D
	select_enemy_scene.queue_free()
	transition_to_selecting_player()


func transition_to_selecting_player():
	state = SELECTING_PLAYER
	$Player.visible = false
	$Enemy.visible = false
	select_player_scene = select_player_packed_scene.instantiate()
	add_child(select_player_scene)
	select_player_scene.battle_menu = self


func add_player_monster(scene):
	scene.reparent($Player)
	scene.position.x = 0
	scene.position.y = 0
	player_monster = scene
	player_hp_bar = $Player/HPBar
	player_hp_bar.set_max_hp(player_monster.max_hp)
	player_sprite = $Player/Monster/Sprite2D
	select_player_scene.queue_free()
	transition_to_select_move()


func transition_to_win():
	var scene = combat_end_scene.instantiate()
	get_parent().add_child(scene)
	scene.outcome = scene.WIN
	scene.victory_sfx.play()
	scene.do_win()
	player_monster.reparent(scene.monster_position)
	player_monster.position.x = 0
	player_monster.position.y = 0
	queue_free()


func transition_to_loss():
	var scene = combat_end_scene.instantiate()
	get_parent().add_child(scene)
	scene.outcome = scene.LOSS
	scene.loss_sfx.play()
	scene.do_loss()
	player_monster.reparent(scene.monster_position)
	player_monster.position.x = 0
	player_monster.position.y = 0
	queue_free()


func execute_player_move(move_number):
	var text = player_monster.excecute_move(move_number, player_monster, enemy_monster)
	battle_log.text += text + "\n"
	update_hp()
	if text.contains("DMG"): 
		shake(enemy_sprite)
		hurt_sfx.play()


func excecute_enemy_move():
	var move_number = enemy_monster.select_move()
	var text = enemy_monster.excecute_move(move_number, enemy_monster, player_monster)
	battle_log.text += text + "\n"
	update_hp()
	if text.contains("DMG"): 
		shake(player_sprite)
		hurt_sfx.play()


func update_hp():
	player_hp_bar.update_hp(player_monster.current_hp)
	enemy_hp_bar.update_hp(enemy_monster.current_hp)


func change_selection():
	if selected_move == 1:
		selected_move = 2
	else:
		selected_move = 1
	update_selected_move()


func shake(sprite):
	var time = 0
	var true_pos = Vector2(sprite.position.x, sprite.position.y)
	var x_offset = 0
	var y_offset = 0
	var intensity = 10
	var duration= 10
	while time < duration:
		x_offset = randf_range(0, intensity)
		y_offset = randf_range(0, intensity)
		sprite.position = true_pos + Vector2(x_offset, y_offset)
		time += 1
		await get_tree().process_frame
	sprite.position = true_pos


func update_selected_move():
	if selected_move == 1:
		move_one_label.set("theme_override_colors/font_color", yellow)
		move_two_label.set("theme_override_colors/font_color", white)
		move_description_label.text = player_monster.m1_description
	else:
		move_two_label.set("theme_override_colors/font_color", yellow)
		move_one_label.set("theme_override_colors/font_color", white)
		move_description_label.text = player_monster.m2_description


func update_move_names():
	move_one_label.text = player_monster.m1_name
	move_two_label.text = player_monster.m2_name


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main Menu.tscn")


func check_for_win_or_loss():
	if enemy_monster.current_hp <= 0:
		transition_to_win()
		return true
	if player_monster.current_hp <= 0:
		transition_to_loss()
		return true
	return false


func _on_turn_timer_timeout():
	if check_for_win_or_loss():
		return
	if state == PLAYER_MOVE:
		transition_to_enemy_move()
	elif state == ENEMY_MOVE:
		transition_to_select_move()
