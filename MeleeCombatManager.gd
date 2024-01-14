extends Node

# ... existing code ...

func calculate_hit(attacker_stats, defender_stats, attacker_bonuses, defender_bonuses):
	var base_hit_chance = 0.9  # Base chance to hit (90%)
	var hit_chance = base_hit_chance * (attacker_stats.melee_stats.attack + attacker_bonuses.total_attack) / (defender_stats.agility_stats.evasion + defender_bonuses.total_evasion)
	
	var random_number = randf()  # Generates a random number between 0 and 1
	
	if random_number <= hit_chance:
		print("Attack lands!")  # Replace this with your attack action
		return true  # Attack successfully lands
	else:
		print("Attack misses!")  # Replace this with your miss action
		return false  # Attack misses

func calculate_damage(attacker_stats, defender_stats, attacker_bonuses, defender_bonuses):
	var hit = calculate_hit(attacker_stats, defender_stats, attacker_bonuses, defender_bonuses)
	
	var damage_dealt = 0

	if hit:
		var base_strength = attacker_stats.melee_stats.strength + attacker_bonuses.total_strength
		var defence = defender_stats.melee_stats.defence + defender_bonuses.total_melee_defence

		# Define a range for the damage (e.g., +/- 10%)
		var damage_range_percent = 0.1
		var damage_min = base_strength * (1.0 - damage_range_percent)
		var damage_max = base_strength * (1.0 + damage_range_percent)

		# Generate a random float within the specified range
		damage_dealt = randf_range(damage_min, damage_max)

	if damage_dealt < 0:
		damage_dealt = 0
	
	# Calculate the actual critical hit chance
	var total_critical_chance = 0.1 + attacker_bonuses.total_critical_bonus + attacker_stats.agility_stats.critical_chance * 0.02

	# Check for a critical hit
	var random_crit = randf()

	if random_crit < total_critical_chance:
		# Apply extra damage for critical hit (e.g., 1.5x to 2x the damage)
		var critical_multiplier = randf_range(1.5, 2.0)
		damage_dealt *= critical_multiplier
		print("Critical hit landed!")  # Add your message here
	return round(damage_dealt)  # Round the damage to the nearest integer





func handle_damage(character_stats, damage_dealt):
	if damage_dealt >= 0:  # Only apply damage if damage_dealt is non-negative (hit)
		character_stats.core_stats.Health -= damage_dealt
		character_stats.core_stats.Health = round(character_stats.core_stats.Health)  # Round to the nearest integer
		
		if character_stats.core_stats.Health < 0:
			character_stats.core_stats.Health = 0
			print("Defender's Health:", character_stats.core_stats.Health)
		else:
			print("Attack misses!")

