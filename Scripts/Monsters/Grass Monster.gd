extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "he grows in the sunlight -u-"

var m1_name = "grass1"
var m1_description = "deals 3-4 DMG"
func move1(user: Monster, enemy: Monster):
	var r = 0
	var min_damage = 3
	var max_damage = 4
	var healing = 1
	r = randi_range(min_damage, max_damage)
	var dmg = deal_damage(r, user, enemy)
	heal(healing, user)
	return "your mon used GRASS1 and did " + str(dmg) + " DMG!\nyour mon healed 1 HP!"


var m2_name = "grass2"
var m2_description = "heals the user 3-4 HP"
func move2(user: Monster, enemy: Monster):
	var r = 0
	var min_healing = 3
	var max_healing = 4
	r = randi_range(min_healing, max_healing)
	heal(r, user)
	return "your mon used GRASS2 and healed itself for " + str(r) + " HP!"
