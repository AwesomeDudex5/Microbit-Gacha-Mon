extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "can lower her DEF to raise her ATT!"
var my_name = "Ruby"

var m1_name = "whack"
var m1_description = "deals 3 DMG"
func move1(user: Monster, enemy: Monster):
	var r = 0
	var min_damage = 3
	var max_damage = 3
	r = randi_range(min_damage, max_damage)
	var dmg = deal_damage(r, user, enemy)
	return "your mon used WHACK and did " + str(dmg) + " DMG!"


var m2_name = "thorns"
var m2_description = "raise your ATT by 2 and lower your DEF by 1"
func move2(user: Monster, enemy: Monster):
	user.current_att += 2
	user.current_def -= 1
	return "your mon used THORNS! it raised its ATT by 2 and lowered its DEF by 1!"
