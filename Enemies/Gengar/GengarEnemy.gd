extends CharacterBody2D
class_name GengarEnemy

@export var move_speed := 10.0

func _physics_process(_delta):
	move_and_slide()

