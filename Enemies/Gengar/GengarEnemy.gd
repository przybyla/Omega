extends CharacterBody2D
class_name GengarEnemy

@export var move_speed: float = 10.0

func _physics_process(delta):
	move_and_slide()
	play_animation()

func play_animation():
	if velocity.length() > 0:
		$AnimatedSprite2D.play("walk")
	if velocity.length() == 0:
		$AnimatedSprite2D.play("idle")

	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
