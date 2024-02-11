extends ActorState
class_name ChaseState

var player: CharacterBody2D
var utils = Utils

func Enter():
	player = utils.find_player()
	print("wchodze w ChaseState")

func state_physics_update(delta: float):
	var direction = player.global_position - actor.global_position
	
	if direction.length() > 25:
		actor.velocity = direction.normalized() * actor.move_speed
		
	elif direction.length() < 10:
		actor.velocity = Vector2()
		Transitioned.emit(self, "AttackState")
	
	if direction.length() > 75:
		Transitioned.emit(self, "IdleState")
