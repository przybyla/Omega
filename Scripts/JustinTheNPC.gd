extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
const speed = 30
var current_state = IDLE
var dir = Vector2.RIGHT
var start_pos
var player

var is_roaming : bool = true
var is_chatting : bool = false
var player_in_chat_zone : bool = false

enum {
	IDLE,
	NEW_DIRECTION,
	MOVE
}

func _ready():
	randomize()
	start_pos = position

func _physics_process(delta):
	if current_state == IDLE or current_state == NEW_DIRECTION:
		animation.play("idle")
	elif current_state == MOVE and !is_chatting:
		if dir.x > 0:
			animation.play("walk")
			animation.flip_h = false
		else:
			animation.play("walk")
			animation.flip_h = true
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIRECTION:
				dir = choose([Vector2.RIGHT, Vector2.UP,Vector2.DOWN,Vector2.LEFT])
			MOVE:
				move()
	if Input.is_action_just_pressed("interact") and player_in_chat_zone:
		print("interacting with NPC")
		is_roaming = false
		is_chatting = true
		animation.play("idle")
	print("chatzone:" + str(player_in_chat_zone))

func choose(array):
	array.shuffle()
	return array.front()
	
func move():
	if !is_chatting:
		velocity = dir * speed
		move_and_slide()

func _on_chat_detection_area_body_entered(body):	
	# check if collider has collision layer 1, which is Player
	if body.collision_layer == 1:
		player_in_chat_zone = true


func _on_chat_detection_area_body_exited(body):
	# check if collider has collision layer 1, which is Player
	if body.collision_layer == 1:
		player_in_chat_zone = false


func _on_timer_timeout():
	$Timer.wait_time = choose([0.5,1,1.5])
	current_state = choose([IDLE, NEW_DIRECTION, MOVE])
