extends Control

enum {WIN, LOSS}
var outcome = WIN
var coins_won = 1
@onready var monster_position = $"Monster Position"
@onready var victory_sfx = $VictorySFX
@onready var loss_sfx = $LossSFX


# Called when the node enters the scene tree for the first time.
func _input(event):
	if (event.is_action_pressed("right_button")):
		go_to_main_menu()
	if (event.is_action_pressed("left_button")):
		go_to_main_menu()
	if (event.is_action_pressed("ui_accept")):
		go_to_main_menu()
	if (event.is_action_pressed("ui_cancel")):
		go_to_main_menu()


func go_to_main_menu():
	queue_free()
	get_tree().change_scene_to_file("res://Scenes/Main Menu.tscn")


func do_loss():
	$Title.text = "you lost."
	$"Lower Text".text = "you got " + str(coins_won) + " coins.\npress any button to continue"
	GameManager.total_coins += coins_won


func do_win():
	$Title.text = "you won!"
	$"Lower Text".text = "you got " + str(coins_won) + " coins!\npress any button to continue"
	GameManager.total_coins += coins_won
	if GameManager.num_of_unlocked_enemies < 6:
		pass
		#GameManager.add_enemy_to_list(enemy_monster.enemy_num)
