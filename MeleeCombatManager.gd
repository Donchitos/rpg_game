extends Resource
class_name MeleeCombatManager

signal meleedamagedeal(int)

func calculate_hit(attacker_stats, defender_stats):
	var base_hit_chance = 0.9  # Base chance to hit (90%)
	var hit_chance = base_hit_chance * attacker_stats.Attack / defender_stats.Agility_Evasion
	
	var random_number = randf()  # Generates a random number between 0 and 1
	
	if random_number <= hit_chance:
		print("Attack lands!")  # Replace this with your attack action
		return true  # Attack successfully lands
	else:
		print("Attack misses!")  # Replace this with your miss action
		return false  # Attack misses

func calculate_damage(attacker_stats, defender_stats):
	var hit = calculate_hit(attacker_stats, defender_stats)
	
	if hit:
		var strength = attacker_stats.Strength
		var defense = defender_stats.Defense
		var damage_dealt = strength * 0.9 - defense
		
		if damage_dealt < 0:
			damage_dealt = 0
		print("Damage Dealt:", damage_dealt)
		meleedamagedeal.emit(damage_dealt)
		print("Signal emitted with Damage Dealt:", damage_dealt)
		return damage_dealt
		

	else:
		return 0  # No damage dealt if the attack misses

func handle_damage(character_stats, damage_dealt):
	if damage_dealt > 0:  # Only apply damage if damage_dealt is greater than 0
		character_stats.Health -= damage_dealt
		character_stats.Health = round(character_stats.Health)  # Round to the nearest integer
		
		if character_stats.Health < 0:
			character_stats.Health = 0
		print("Defender's Health:", character_stats.Health)
