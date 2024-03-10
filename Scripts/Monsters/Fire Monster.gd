extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "increases his ATT and hits twice in one turn to make the most of it!"
var my_name = "Zachary"

var m1_name = "burn"
var m1_description = "deals 1-2 DMG twice"
func move1(user: Monster, enemy: Monster):	
	var min_damage = 1
	var max_damage = 2
	var r = randi_range(min_damage, max_damage)
	var dmg1 = deal_damage(r, user, enemy)
	r = randi_range(min_damage, max_damage)
	var dmg2 = deal_damage(r, user, enemy)
	return "your mon used BURN for " + str(dmg1) + " DMG and " + str(dmg2) + " DMG!"


var m2_name = "heat up"
var m2_description = "raises ATT by 1"
func move2(user: Monster, enemy: Monster):
	user.current_att += 1
	return "your mon used HEAT UP and increased its ATT by 1!"
