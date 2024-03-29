extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "does inconsistent damage and heals himself"
var my_name = "Matthew"

var m1_name = "icicles"
var m1_description = "deals 1-3 DMG twice"
func move1(user: Monster, enemy: Monster):	
	var min_damage = 1
	var max_damage = 3
	var r = randi_range(min_damage, max_damage)
	var dmg1 = deal_damage(r, user, enemy)
	r = randi_range(min_damage, max_damage)
	var dmg2 = deal_damage(r, user, enemy)
	return "your mon used ICICLES for " + str(dmg1) + " DMG and " + str(dmg2) + " DMG!"


var m2_name = "sap"
var m2_description = "deals 2 DMG and heals for 2"
func move2(user: Monster, enemy: Monster):
	var r = deal_damage(2, user, enemy)
	var h = heal(2, user)
	return "your mon used SAP for " + str(r) + " DMG!\nit healed " + str(h) + " HP!"
