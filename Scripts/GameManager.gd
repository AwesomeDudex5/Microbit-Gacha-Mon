extends Node

var total_coins = 0
var pals_inventory = [
	preload("res://Scenes/Monsters/Fire Monster.tscn"), 
	preload("res://Scenes/Monsters/Water Monster.tscn"), 
	preload("res://Scenes/Monsters/Grass Monster.tscn")
]
var pal_list = [
	preload("res://Scenes/Monsters/Fire Monster.tscn"), 
	preload("res://Scenes/Monsters/Water Monster.tscn"), 
	preload("res://Scenes/Monsters/Grass Monster.tscn")
]

var unlocked_enemies = []
var enemy_list = [
	preload("res://Scripts/Enemies/Enemy1.gd")
]
var num_of_unlocked_enemies = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	unlocked_enemies.append(enemy_list[0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
