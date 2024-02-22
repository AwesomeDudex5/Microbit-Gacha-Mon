extends Node

var roll_cost = 1

@onready var gacha_menu_node = $".."
@onready var pal_sprite = $"Pal Sprite"
@onready var coins_label = $"Coins Available"


# Called when the node enters the scene tree for the first time.
func _ready():
	#initialize gacha signal and base spprite
	gacha_menu_node.connect("start_gacha", gacha_roll)
	pal_sprite.texture = load("res://Sprites/capsule.png")
	coins_label.text = "Coins Owned: " + str(GameManager.total_coins)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	coins_label.text = "Coins Owned: " + str(GameManager.total_coins)
	

func gacha_roll():
	print("Rolling")
	if(GameManager.total_coins >= roll_cost):
		# Roll New Pal
		var random_index = randi() % GameManager.pal_list.size()
		pal_sprite.texture = load(GameManager.pal_list[random_index])
		
		#store the index of the pal so can call it from Pal List
		GameManager.pals_inventory.append(random_index)
		
		#Adjust Coins
		GameManager.total_coins -= 1
		
		# Debug
		print("Got new Pal")
		print(GameManager.pals_inventory)
	else:
		print("Not Enough Coins")
	
	
