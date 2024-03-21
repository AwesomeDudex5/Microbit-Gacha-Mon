extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var charge_count = 0
func select_move():
	if charge_count == 3:
		charge_count = 0
		return 2
	charge_count += 1
	return 1
var description = "charges off and then lets off a boom! don't under estimate him!"
var my_name = "Bradley"

var m1_name = "charge"
var m1_description = "stores power"
func move1(user: Monster, enemy: Monster):
	var r = randi_range(0, 1)
	if r == 1:
		current_def += 1
		return "enemy mon used CHARGE! it's storing power... its DEF raised by 1!"
	return "enemy mon used CHARGE! it's storing power..."


var m2_name = "blast"
var m2_description = "deals 12 DMG"
func move2(user: Monster, enemy: Monster):
	var dmg = 12
	dmg = deal_damage(dmg, user, enemy)
	return "enemy mon used BLAST for " + str(dmg) + " DMG!"
