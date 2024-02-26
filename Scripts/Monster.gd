class_name Monster
extends Node

@export var max_hp = 10
@export var starting_att = 0
@export var starting_def = 0
var moves = []
@onready var MoveList = get_child(0)
@onready var current_hp = max_hp
@onready var current_att = starting_att
@onready var current_def = starting_def

func select_move():
	return randi_range(1, 2)


func excecute_move(move_number, user, enemy):
	return moves[move_number - 1].call(user, enemy)


func deal_damage(n, user: Monster, target: Monster):
	var damage_dealt = n + user.current_att - target.current_def
	if damage_dealt < 0:
		damage_dealt = 0
	target.current_hp -= damage_dealt
	if target.current_hp < 0:
		target.current_hp = 0
	return damage_dealt


func heal(n, target: Monster):
	target.current_hp += n
	if target.current_hp > target.max_hp:
		target.current_hp = target.max_hp
