extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "this guy is a little tough. watch out for his heal!"

var m1_name = "hit"
var m1_description = "deals 3 DMG"
func move1(user: Monster, enemy: Monster):
	var dmg = deal_damage(3, user, enemy)
	return "enemy mon used HIT for " + str(dmg) + " DMG!"


var m2_name = "heal"
var m2_description = "heals 2 HP"
func move2(user: Monster, enemy: Monster):
	var heal = heal(2, user)
	return "enemy mon used HEAL and healed " + str(heal) + " HP!"
