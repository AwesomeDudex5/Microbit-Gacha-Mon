extends Control

var selected_move = 1
var yellow = Color(1.0, 1.0, 0.0, 1.0)
var white = Color(1.0, 1.0, 1.0, 1.0)
@onready var player_monster = $Player/Monster
@onready var enemy_monster = $Enemy/Monster
@onready var enemy_sprite = $Enemy/Sprite2D
@onready var player_sprite = $Player/Sprite2D
@onready var hurt_sfx = $HurtSFX
@onready var battle_log = $BattleLog
@onready var turn_timer = $TurnTimer
@onready var player_hp_bar = $Player/HPBar
@onready var enemy_hp_bar = $Enemy/HPBar
@onready var move_one_container = $"Player/Move One"
@onready var move_two_container = $"Player/Move Two"
@onready var move_one_label = $"Player/Move One/Name"
@onready var move_two_label = $"Player/Move Two/Name"
@onready var move_description = $"Player/Move Description"
@onready var move_description_label = $"Player/Move Description/Margin/Description"

enum {NO_MON_SELECTED, MOVE_SELECTION, PLAYER_MOVE, ENEMY_MOVE}
var state = MOVE_SELECTION

func _ready():
	update_selected_move()
	update_move_names()
	player_sprite.texture = player_monster.sprite
	enemy_sprite.texture = enemy_monster.sprite
	player_hp_bar.set_max_hp(player_monster.max_hp)
	enemy_hp_bar.set_max_hp(enemy_monster.max_hp)


func _input(event):
	if state == MOVE_SELECTION:
		if event.is_action_pressed("make selection"):
			transition_to_player_move()
		if event.is_action_pressed("toggle selection"):
			change_selection()


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
	move_one_container.visible = true
	move_two_container.visible = true
	move_description.visible = true


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
	pass


func _on_turn_timer_timeout():
	check_for_win_or_loss()
	if state == PLAYER_MOVE:
		transition_to_enemy_move()
	elif state == ENEMY_MOVE:
		transition_to_select_move()
