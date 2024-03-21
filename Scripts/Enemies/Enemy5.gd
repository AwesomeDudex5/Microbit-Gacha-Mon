extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "this guy's got high defense! don't let their low HP fool you!"
var my_name = "Kris"

var m1_name = "kick"
var m1_description = "deals 4 DMG"
func move1(user: Monster, enemy: Monster):
	var dmg = deal_damage(4, user, enemy)
	return "enemy mon used KICK for " + str(dmg) + " DMG!"


var m2_name = "sap"
var m2_description = "deals 3 DMG and heals self for 2"
func move2(user: Monster, enemy: Monster):
	var dmg = deal_damage(2, user, enemy)
	var heal = heal(2, user)
	return "enemy mon used SAP for " + str(dmg) + " DMG!\nenemy mon healed " + str(heal) + " HP!"
