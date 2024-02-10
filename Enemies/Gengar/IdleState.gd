extends State
class_name IdleState

@export var enemy := CharacterBody2D
@export var wander_time_min: float = 1
@export var wander_time_max: float = 5

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	# we need to generate random duration of this wander
	wander_time = randf_range(wander_time_min, wander_time_max)
	
	# 25% (1 in 4) chance that the move direction will be zero to enable enemy to idle in place
	# value 0 will be casted to bool as FALSE, any other value (>0) will be casted to bool as TRUE
	var should_move = randi_range(0, 4) as bool
	move_direction = Vector2(randf_range(-1, 1), randf_range(1,1)).normalized() if should_move else Vector2.ZERO

func Enter():
	randomize_wander()

func state_update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func state_physics_update(_delta: float):
	if enemy:
		enemy.velocity = move_direction * enemy.move_speed
