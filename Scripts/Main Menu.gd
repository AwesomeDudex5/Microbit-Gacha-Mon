extends Control



func _on_gacha_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Gacha Menu.tscn")




func _on_battle_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Battle Menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
