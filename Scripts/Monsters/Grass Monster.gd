extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "leeches HP slowly or heals itself fully!"
var my_name = "Quinten"

var m1_name = "leech"
var m1_description = "deals 3-4 DMG and heals 1 HP"
func move1(user: Monster, enemy: Monster):
	var r = 0
	var min_damage = 3
	var max_damage = 4
	var healing = 1
	r = randi_range(min_damage, max_damage)
	var dmg = deal_damage(r, user, enemy)
	heal(healing, user)
	return "your mon used LEECH and did " + str(dmg) + " DMG!\nyour mon healed 1 HP!"


var m2_name = "regrow"
var m2_description = "heals the user to max HP"
func move2(user: Monster, enemy: Monster):
	var r = 12
	heal(r, user)
	return "your mon used REGROW and healed itself for " + str(r) + " HP!"
