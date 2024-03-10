extends TextureProgressBar

@onready var label = $Label

func update_hp(n):
	value = n
	label.text = str(n)


func set_max_hp(n):
	max_value = n
	update_hp(n)
