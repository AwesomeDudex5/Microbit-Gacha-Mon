extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "an all-arounder. can increase his DEF!"
var my_name = "Maxwell"

var m1_name = "torrent"
var m1_description = "deals 4-5 DMG"
func move1(user: Monster, enemy: Monster):
	var r = 0
	var min_damage = 4
	var max_damage = 5
	r = randi_range(min_damage, max_damage)
	var dmg = deal_damage(r, user, enemy)
	return "your mon used TORRENT for " + str(dmg) + " DMG!"


var m2_name = "protect"
var m2_description = "raises DEF by 1"
func move2(user: Monster, enemy: Monster):
	user.current_def += 1
	return "your mon used PROTECT and raised its DEF by 1!"
