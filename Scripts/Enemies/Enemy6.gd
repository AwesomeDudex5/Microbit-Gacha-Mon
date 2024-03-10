extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "he get's better at executing his moves over time!"
var my_name = "Mark"

var m1_name = "boop"
var m1_description = "deals 2 DMG and gets stronger over time"
var boop_buff = 0
func move1(user: Monster, enemy: Monster):
	var dmg = deal_damage(2 + boop_buff, user, enemy)
	boop_buff += 1
	return "enemy mon used BOOP for " + str(dmg) + " DMG!\nBOOP got stronger!"


var m2_name = "beep"
var m2_description = "deals 2 DMG and gets stronger over time"
var beep_buff = 0
func move2(user: Monster, enemy: Monster):
	var dmg = deal_damage(2 + beep_buff, user, enemy)
	beep_buff += 1
	return "enemy mon used BEEP for " + str(dmg) + " DMG!\nBEEP got stronger!"
