extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "he's a little fire guy. what else do you want?"

var m1_name = "fire1"
var m1_description = "deals 1-2 DMG"
func move1(user: Monster, enemy: Monster):	
	var min_damage = 1
	var max_damage = 2
	var r = randi_range(min_damage, max_damage)
	var dmg1 = deal_damage(r, user, enemy)
	r = randi_range(min_damage, max_damage)
	var dmg2 = deal_damage(r, user, enemy)
	return "your mon used FIRE1 for " + str(dmg1) + " DMG and " + str(dmg2) + " DMG!"


var m2_name = "fire2"
var m2_description = "charges for one turn and then uses a strong attack"
func move2(user: Monster, enemy: Monster):
	m1_name = "explosion"
	m2_name = "explosion"
	m1_description = "deals 6-8 DMG"
	m2_description = "deals 6-8 DMG"
	return "your mon started charging its attack!"
