extends CharacterBody2D

const speed = 100.0

func _physics_process(delta):
	update_velocity_from_input()
	var isCollisionDetected = move_and_slide()
	if isCollisionDetected:
		print("collision!")
	
func update_velocity_from_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	play_animation(velocity)
	
func play_animation(velocity):
	var anim = $AnimatedSprite2D
	
	if velocity == Vector2.ZERO:
		anim.play('idle')
		return
	else:
		anim.play('run')
	
	if velocity.x > 0:
		anim.flip_h = false
	else:
		anim.flip_h = true
