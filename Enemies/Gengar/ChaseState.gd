extends ActorState
class_name ChaseState

@export var attack_state: AttackState
@export var idle_state: IdleState
@export var chase_range_min: float = 10.0
@export var chase_range_max: float = 75.0

var player: CharacterBody2D
var utils = Utils

func _ready():
	super._ready()
	assert(attack_state != null, "no reference to attack state found")
	assert(idle_state != null, "no reference to idle state found")

func Enter():
	player = utils.find_player()
	print("wchodze w ChaseState")

func state_physics_update(delta: float):
	var direction = player.global_position - actor.global_position
	
	if direction.length() > 25:
		actor.velocity = direction.normalized() * actor.move_speed
		
	elif direction.length() < attack_state.attack_range:
		actor.velocity = Vector2()
		Transitioned.emit(self, attack_state.name)
	
	if direction.length() > chase_range_max:
		Transitioned.emit(self, idle_state.name)
