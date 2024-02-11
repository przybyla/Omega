extends CharacterBody2D
class_name GengarEnemy

@export var move_speed: float = 10.0
@export var animated_sprite_2d: AnimatedSprite2D
@export var attack_range: float = 10.0

func _physics_process(delta):
	move_and_slide()
	play_animation()

func play_animation():
	if velocity.length() > 0:
		animated_sprite_2d.play("walk")
	if velocity.length() == 0:
		animated_sprite_2d.play("idle")

	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
