extends State
class_name IdleState

@export var enemy := CharacterBody2D
@export var wander_time_min: float = 1
@export var wander_time_max: float = 5
@export var max_wander_distance_from_start: float = 50

var move_direction : Vector2
var wander_time : float
var starting_position: Vector2

func randomize_wander():
	# we need to generate random duration of this wander
	wander_time = randf_range(wander_time_min, wander_time_max)
	
	# 25% (1 in 4) chance that the move direction will be zero to enable enemy to idle in place
	# value 0 will be casted to bool as FALSE, any other value (>0) will be casted to bool as TRUE
	var should_move = randi_range(0, 4) as bool
	move_direction = Vector2(randf_range(-1, 1), randf_range(1,1)).normalized() if should_move else Vector2.ZERO
	
	# if we are going to move, but the max wander distance from starting position has been exceeded
	# then we should move towards the starting position
	var current_position_to_starting_position = starting_position - enemy.position
	if current_position_to_starting_position.length() > max_wander_distance_from_start:
		move_direction = current_position_to_starting_position.normalized()

func Enter():
	starting_position = enemy.position
	randomize_wander()

func state_update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func state_physics_update(_delta: float):
	if enemy:
		enemy.velocity = move_direction * enemy.move_speed
