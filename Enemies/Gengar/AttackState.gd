extends ActorState
class_name AttackState

@export var chase_state: ChaseState
@export var idle_state: IdleState
@export var attack_range_min: float = 10.0
@export var attack_range_max: float = 25.0

var player : CharacterBody2D
var utils = Utils

func _ready():
	super._ready()
	assert(chase_state != null, "no reference to chase state found")
	assert(idle_state != null, "no reference to idle state found")

func Enter():
	player = utils.find_player()
	print("wchodze w AttackState")

func state_physics_update(delta: float):
	var direction = player.global_position - actor.global_position
	
	if direction.length() > attack_range_min:
		Transitioned.emit(self, chase_state.name)
	
	if direction.length() > chase_state.chase_range_max:
		Transitioned.emit(self, idle_state.name)
