extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var m1_name = "smack"
var m1_description = "deals 1 DMG"
func move1(user: Monster, enemy: Monster):
	var dmg = deal_damage(1, user, enemy)
	return "enemy mon used SMACK for " + str(dmg) + " DMG!"


var m2_name = "hit"
var m2_description = "deals 3 DMG"
func move2(user: Monster, enemy: Monster):
	var dmg = deal_damage(3, user, enemy)
	return "enemy mon used HIT for " + str(dmg) + " DMG!"
