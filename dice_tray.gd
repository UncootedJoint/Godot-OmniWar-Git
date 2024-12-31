extends Node

func d10():
	return randi_range(1, 10)


func d10_plus(): 
	var total = 0
	var exploding = true
	while exploding == true:
		var result = d10()
		total += result
		if result < 10:
			exploding = false
	return total


func effect_roll(number_of_dice := 1, target_number := 10, capacity := 999):
	var result = {
		"effect" : 0,
		"fails" : 0
	}
	var count = 0
	while count < number_of_dice:
		var die = d10()
		var count_result = 0
		if die > target_number:
			result["fails"] += d10()
		elif die == target_number:
			count_result += die + d10_plus()
		elif die < target_number:
			count_result += die
		
		if count_result > capacity:
			count_result = capacity
		result["effect"] += count_result
		count += 1
		
	return result
