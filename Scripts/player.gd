extends CharacterBody2D

const speed = 100.0
@export var journalScene: PackedScene
var journalInstance: Node

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_J:
			toggle_journal_ui();

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

func toggle_journal_ui():
	if (journalScene.can_instantiate() == false):
		push_error("journal scene is not preloaded yet, cannot instantiate!")
		return
		
	
	if (is_instance_valid(journalInstance)):
		# if journal instance already exists remove it
		print("hiding journal UI")
		journalInstance.queue_free()
	else:
		# otherwise instantiate it
		print("showing journal UI")
		journalInstance = journalScene.instantiate()
		add_child(journalInstance)
	
