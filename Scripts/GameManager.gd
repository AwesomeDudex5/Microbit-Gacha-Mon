extends Node

# victory jingle from:
# https://freesound.org/people/LittleRobotSoundFactory/sounds/274181/
# using with CC 4.0 by LittleRobotSoundFactory
# loss jingle from:
# https://freesound.org/people/LittleRobotSoundFactory/sounds/270329/
# using with CC 4.0 by LittleRobotSoundFactory

var total_coins = 3
var pals_inventory = [
]
var pal_list = [
	preload("res://Scenes/Monsters/Water Monster2.tscn"),
	preload("res://Scenes/Monsters/Grass Monster2.tscn"),
	preload("res://Scenes/Monsters/Fire Monster2.tscn"), 
	preload("res://Scenes/Monsters/Fire Monster.tscn"), 
	preload("res://Scenes/Monsters/Water Monster.tscn"), 
	preload("res://Scenes/Monsters/Grass Monster.tscn")
]

var unlocked_enemies = [
]
var enemy_list = [
	preload("res://Scripts/Enemies/Enemy1.gd"),
	preload("res://Scripts/Enemies/Enemy2.gd"),
	preload("res://Scripts/Enemies/Enemy3.gd"),
	preload("res://Scripts/Enemies/Enemy4.gd"),
	preload("res://Scripts/Enemies/Enemy5.gd"),
	preload("res://Scripts/Enemies/Enemy6.gd")
]
var num_of_unlocked_enemies = 1
var max_enemies = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	unlocked_enemies.append(enemy_list[0])


func add_enemy_to_list(n):
	print("HERRERREHERHREBdnkankjfdnkjfda")
	if num_of_unlocked_enemies >= 6:
		print("too many enemies")
		return
	if n < num_of_unlocked_enemies:
		print("n is lower than number of unlocked enemies")
		return
	num_of_unlocked_enemies += 1
	unlocked_enemies.append(enemy_list[n])
	print("added enemy " + str(n))
