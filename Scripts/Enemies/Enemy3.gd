extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

func select_move():
	var n = randi_range(1, 5)
	if n < 4:
		n = 1
	else:
		n = 2
	return n

var description = "kind of dumb... hits hard, but sometimes does nothing"
var my_name = "Miriam"

var m1_name = "doze off"
var m1_description = "does nothing"
func move1(user: Monster, enemy: Monster):
	return "enemy mon used DOZE OFF! it did nothing..."


var m2_name = "wallop"
var m2_description = "deals 6 DMG"
func move2(user: Monster, enemy: Monster):
	var dmg = deal_damage(6, user, enemy)
	return "enemy mon used WALLOP for " + str(dmg) + " DMG!"
