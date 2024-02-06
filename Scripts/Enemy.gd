extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var speed: float  = 25.0
var chase_player: bool = false
var direction: Vector2
var current_state = IDLE
var player

enum { IDLE, CHASE }

func _physics_process(delta):
	play_animation()
	enemy_move()
	print(current_state)


func enemy_move() -> void:
	if current_state == CHASE:
		direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()

func play_animation() -> void:
	if current_state == IDLE:
		anim.play('idle')
	elif current_state == CHASE:
		if direction.x > 0:
			anim.play("walk")
			anim.flip_h = false
		else:
			anim.play("walk")
			anim.flip_h = true

func _on_detection_area_body_entered(body):
	player = body
	current_state = CHASE


func _on_chase_area_body_exited(body):
	player = null
	current_state = IDLE
