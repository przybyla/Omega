extends ActorState
class_name AttackState

var player : CharacterBody2D
var utils = Utils

func Enter():
	player = utils.find_player()
	print("wchodze w AttackState")

func state_physics_update(delta: float):
	var direction = player.global_position - actor.global_position
	
	if direction.length() > 25:
		Transitioned.emit(self, "ChaseState")
	
	if direction.length() > 75:
		Transitioned.emit(self, "IdleState")
