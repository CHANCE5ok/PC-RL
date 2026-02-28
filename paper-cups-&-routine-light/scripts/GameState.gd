extends Node

var fatigue: float = 0.0
var burnout: float = 0.0
var reputation: float = 0.0

const FATIGUE_MAX := 100.0
const BURNOUT_MAX := 100.0

const POSITIVE_COST := 12.0
const NEUTRAL_COST := 4.0
const HONEST_COST := 2.0
const RUDE_COST := 6.0

const FATIGUE_RECOVERY_AFTER_MINIGAME := 5.0
const FATIGUE_TO_BURNOUT_RATIO := 0.25


func choice_positive():
	fatigue += POSITIVE_COST
	reputation += 5
	print("Positive choice triggered")
	print("Fatigue:", fatigue, "Reputation:", reputation)
	_check_limits()

func choice_neutral():
	fatigue += NEUTRAL_COST
	reputation += 1
	_check_limits()

func choice_honest():
	fatigue += HONEST_COST
	reputation += 2
	_check_limits()

func choice_rude():
	fatigue += RUDE_COST
	reputation -= 5
	_check_limits()

func after_minigame(success: bool):
	if success:
		reputation += 3
	else:
		reputation -= 4
	
	fatigue -= FATIGUE_RECOVERY_AFTER_MINIGAME
	if fatigue < 0:
		fatigue = 0
	
	_check_limits()

func end_day():
	burnout += fatigue * FATIGUE_TO_BURNOUT_RATIO
	if burnout > BURNOUT_MAX:
		burnout = BURNOUT_MAX
	
	fatigue = 0

func is_too_tired_for_positive() -> bool:
	return fatigue >= 70

func is_burned_out() -> bool:
	return burnout >= 80

func _check_limits():
	if fatigue > FATIGUE_MAX:
		fatigue = FATIGUE_MAX
	if burnout > BURNOUT_MAX:
		burnout = BURNOUT_MAX
