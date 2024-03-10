extends Monster

func _ready():
	moves.append(move1)
	moves.append(move2)

var description = "can charge up to unleash a powerful ATT!"
var my_name = "Kris"

var is_charging = false

var m1_name = "char"
var m1_original_name = m1_name
var m1_description = "deals 2-5 DMG"
var m1_original_description = m1_description
func move1(user: Monster, enemy: Monster):
	if is_charging:
		return charge_attack(user, enemy)
	
	var min_damage = 2
	var max_damage = 5
	var r = randi_range(min_damage, max_damage)
	var dmg = deal_damage(r, user, enemy)
	return "your mon used CHAR for " + str(dmg) + " DMG!"


var m2_name = "charge"
var m2_original_name = m2_name
var m2_description = "charges for one turn and then uses a strong attack"
var m2_original_description = m2_description
func move2(user: Monster, enemy: Monster):
	if is_charging:
		return charge_attack(user, enemy)
	
	is_charging = true
	m1_name = "explosion"
	m2_name = "explosion"
	m1_description = "deals 6-8 DMG"
	m2_description = "deals 6-8 DMG"
	return "your mon started charging its attack!"


func charge_attack(user: Monster, enemy: Monster):
	var r = 0
	var min_damage = 6
	var max_damage = 8
	r = randi_range(min_damage, max_damage)
	var dmg = deal_damage(r, user, enemy)
	m1_name = m1_original_name
	m2_name = m2_original_name
	m1_description = m1_original_description
	m2_description = m2_original_description
	is_charging = false
	return "your mon used EXPLOSION for " + str(dmg) + " DMG!"
