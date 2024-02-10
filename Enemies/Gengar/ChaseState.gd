extends State
class_name ChaseState

@export var enemy: CharacterBody2D
var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	print("wchodze w ChaseState")

func state_physics_update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 25:
		enemy.velocity = direction.normalized() * enemy.move_speed
		
	elif direction.length() < 10:
		enemy.velocity = Vector2()
		Transitioned.emit(self, "AttackState")
	
	if direction.length() > 75:
		Transitioned.emit(self, "IdleState")
