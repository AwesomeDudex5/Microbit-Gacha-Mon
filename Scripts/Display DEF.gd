extends Sprite2D

@onready var label = $Label

func update_def(n):
	label.text = "[b][center] DEF\n" + str(n) + "[/center]"
