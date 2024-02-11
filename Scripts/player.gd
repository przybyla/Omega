class_name Player
extends CharacterBody2D

@export var inventoryData: InventoryData
const speed = 100.0

signal toggle_inventory()
signal toggle_jourrnal()

func _input(event):
	if  Input.is_action_just_pressed("journal"):
		toggle_jourrnal.emit();
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit();

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
