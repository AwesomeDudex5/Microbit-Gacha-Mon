extends Node

var roll_cost = 1
var old_pal = null

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
		if old_pal != null:
			old_pal.queue_free()
		
		var random_index = randi() % GameManager.pal_list.size()
		var pal = GameManager.pal_list[random_index]
		pal = pal.instantiate()
		pal_sprite.add_child(pal)
		pal.position = Vector2.ZERO
		pal.scale = Vector2(3, 3)
		old_pal = pal
		
		pal_sprite.self_modulate = Color(0, 0, 0, 0)
		
		#store the index of the pal so can call it from Pal List
		GameManager.pals_inventory.append(GameManager.pal_list[random_index])
		
		#Adjust Coins
		GameManager.total_coins -= roll_cost
		
		# Debug
		print("Got new Pal")
		print(GameManager.pals_inventory)
	else:
		print("Not Enough Coins")
	
	
