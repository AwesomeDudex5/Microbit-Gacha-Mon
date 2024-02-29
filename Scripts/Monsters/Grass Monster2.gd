extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "can lower his DEF to raise his ATT!"

var m1_name = "grass1"
var m1_description = "deals 3-4 DMG"
func move1(user: Monster, enemy: Monster):
	var r = 0
	var min_damage = 3
	var max_damage = 3
	r = randi_range(min_damage, max_damage)
	var dmg = deal_damage(r, user, enemy)
	return "your mon used GRASS1 and did " + str(dmg) + " DMG!"


var m2_name = "grass2"
var m2_description = "raise your ATT by 2 and lower your DEF by 1"
func move2(user: Monster, enemy: Monster):
	user.current_att += 2
	user.current_def -= 1
	return "your mon used GRASS2! it raised its ATT by 2 and lowered its DEF by 1!"
