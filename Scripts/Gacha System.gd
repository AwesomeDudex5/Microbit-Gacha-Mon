extends Node

signal end_gacha

var roll_cost = 2
var old_pal = null

var rolling_state = false
var coin_inserted = false
var crank_set = false
var finished_rolling = false
var is_rolling = false

@onready var gacha_menu_node = $".."
@onready var capsule_machine_sprite = $"Capsule Machine Sprite"
@onready var pal_sprite = $"Pal Sprite"
@onready var coins_label = $"Coins Available"
@onready var anim_player = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer2D

var audio_stream : AudioStream
var mon_get_sound = "res://Sounds/mon_get.wav"
var gacha_crank_sound = "res://Sounds/crank.wav"
var coin_insert_sound = "res://Sounds/coin_insert.wav"
var rolling_sound = "res://Sounds/rolling2.wav"
var crank_rotation_unit = 1
var global_delta = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	#initialize gacha signal and base spprite
	gacha_menu_node.connect("start_gacha", set_rolling_menu)
	set_gacha_menu()
	pal_sprite.texture = load("res://Sprites/UI/capsule.png")
	coins_label.text = "Coins Owned: " + str(GameManager.total_coins)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	coins_label.text = "Coins Owned: " + str(GameManager.total_coins)
	global_delta = delta

func _input(event):
	if(rolling_state == true && finished_rolling == false && !GameManager.has_all_mons()):
		if(event.is_action_pressed("left_button") || event.is_action_pressed("ui_accept")):
			coin_inserted = true
			rolling_state = false
			audio_stream = load(coin_insert_sound)
			audio_player.stream = audio_stream
			audio_player.play()
			print("Coin Inserted")
			await get_tree().create_timer(1.25).timeout
			# --------------------------------------------
			audio_stream = load(gacha_crank_sound)
			audio_player.stream = audio_stream
			audio_player.play()
			# --------------------------------------------
			gacha_roll()
	if(finished_rolling == true):
		if(event.is_action_pressed("left_button") || event.is_action_pressed("ui_cancel")):
			pal_sprite.self_modulate = Color(1, 1, 1, 1)
			set_gacha_menu()
			finished_rolling = false
			get_viewport().set_input_as_handled()
			emit_signal("end_gacha")


func set_rolling_menu():
	rolling_state = true
	$"Crank Dial Text".visible = true
	$"Dial Sprite".visible = true
	$"Coins to Roll".visible = false
	$"Coins Available".visible = false
	$"../Buttons/Roll Button".visible = false
	$"../Buttons/Back Button".visible = false
	$"Old Mon Acquired".visible = false
	$"New Mon Acquired".visible = false
	
	capsule_machine_sprite.visible = false
	pal_sprite.visible = false
	pal_sprite.texture = load("res://Sprites/UI/capsule.png")
	
func set_gacha_menu():
	rolling_state = false
	$"Crank Dial Text".visible = false
	$"Dial Sprite".visible = false
	$"Coins to Roll".visible = true
	$"Coins Available".visible = true
	$"../Buttons/Roll Button".visible = true
	$"../Buttons/Back Button".visible = true
	$"Old Mon Acquired".visible = false
	$"New Mon Acquired".visible = false
	if(old_pal != null):
		old_pal.visible = false
	capsule_machine_sprite.visible = true
	pal_sprite.visible = true
	pal_sprite.texture = load("res://Sprites/UI/capsule.png")
	
	emit_signal("end_gacha")
	if GameManager.has_all_mons():
		print("HEREHREHREHEHHREHRE")




func gacha_roll():
	print("Rolling")
	if (is_rolling):
		return
	
	#-----Play capsule animation
	$"Crank Dial Text".visible = false
	
	var duration = 1.5
	var time = 0.0
	var old_r = 0.0
	var new_r = TAU
	var r = old_r
	
	while time < duration:
		var t = time / duration
		t = ease_in_back(t)
		
		r = lerp(old_r, new_r, t)
		$"Dial Sprite".rotation = r
		
		time += global_delta
		await get_tree().process_frame
	
	$"Dial Sprite".rotation = new_r
	
	await get_tree().create_timer(.25).timeout
	
	$"Dial Sprite".visible = false
	pal_sprite.texture = load("res://Sprites/UI/capsule.png")
	anim_player.play("capsule_roll")
	await get_tree().create_timer(1.1).timeout
	
	is_rolling = false
	
	audio_stream = load(mon_get_sound)
	audio_player.stream = audio_stream
	audio_player.play()
	
	
	if(GameManager.pals_inventory.size() >= 6):
		$"All Mons Obtained".visible = true
		return
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
		if !GameManager.pals_inventory.has(GameManager.pal_list[random_index]):
			GameManager.pals_inventory.append(GameManager.pal_list[random_index])
			$"New Mon Acquired".visible = true
		else:
			$"Old Mon Acquired".visible = true
		
		#Adjust Coins
		GameManager.total_coins -= roll_cost
		
		finished_rolling = true
		
		# Debug
		print("Got new Pal")
		print(GameManager.pals_inventory)
	else:
		print("Not Enough Coins")
	
	

func ease_in_out_back(x):
	const c1 = 1.70158
	const c2 = c1 * 1.525
	if x < 0.5:
		return (pow(2 * x, 2) * ((c2 + 1) * 2 * x - c2)) / 2
	else:
		return (pow(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2

func ease_in_back(x):
	const c1 = 1.70158
	const c3 = c1 + 1
	return c3 * x * x * x - c1 * x * x
