extends Node

var pointing_at = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func turn(n: int):
	assert(n >= 0 || n <= 5, "turning the crank to a number that's too low or too high: " + str(n))
	pointing_at = n
