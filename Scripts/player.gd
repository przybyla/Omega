extends CharacterBody2D


const speed = 100.0
var current_dir = 'none'

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	
	if Input.is_action_pressed('right'):
		current_dir = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed('left'):
		current_dir = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed('down'):
		current_dir = "down"
		play_animation(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed('up'):
		current_dir = "up"
		play_animation(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func play_animation(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == 'right':
		anim.flip_h = false
		if movement == 1:
			anim.play('run')
		elif movement == 0:
			anim.play('idle')
	if dir == 'left':
		anim.flip_h = true
		if movement == 1:
			anim.play('run')
		elif movement == 0:
			anim.play('idle')
	if dir == 'up':
		if movement == 1:
			anim.play('run')
		elif movement == 0:

				anim.play('idle')
	if dir == 'down':
		if movement == 1:
			anim.play('run')
		elif movement == 0:
			anim.play('idle')

