extends ActorState
class_name IdleState

@export var wander_time_min: float = 1
@export var wander_time_max: float = 5
@export var max_wander_distance_from_start: float = 50
# values range 0.0 (0%) to 1.0 (100%)
@export var probability_of_standing_in_place: float = 0.25
@export var chase_state: ChaseState

var player : CharacterBody2D
var move_direction : Vector2
var wander_time : float
var starting_position: Vector2
var utils = Utils

func _ready():
	super._ready()
	assert(chase_state != null, "no reference to chase state found")

func randomize_wander():
	# we need to generate random duration of this wander
	wander_time = randf_range(wander_time_min, wander_time_max)
	
	# 25% (1 in 4) chance that the move direction will be zero to enable enemy to idle in place
	# value 0 will be casted to bool as FALSE, any other value (>0) will be casted to bool as TRUE
	var should_move = randi_range(0, (int)(1.0 / probability_of_standing_in_place)) as bool
	move_direction = Vector2(randf_range(-1, 1), randf_range(1,1)).normalized() if should_move else Vector2.ZERO
	
	# if we are going to move, but the max wander distance from starting position has been exceeded
	# then we should move towards the starting position
	var current_position_to_starting_position = starting_position - actor.position
	if current_position_to_starting_position.length() > max_wander_distance_from_start:
		move_direction = current_position_to_starting_position.normalized()

func Enter():
	player = utils.find_player()
	starting_position = actor.position
	randomize_wander()
	print("Wchodze w IdleState")

func state_update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func state_physics_update(_delta: float):
	if actor:
		actor.velocity = move_direction * actor.move_speed
	
	var direction = player.global_position - actor.global_position
	
	if direction.length() > 10 && direction.length() < 75:
		Transitioned.emit(self, chase_state.name)
