class_name ActorState
extends State

var actor: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# we are waiting for the owner (top level node, player or enemy in case of state machine)
	# to emit ready event after it's _ready() function has ran
	await owner.ready
	# with assert we make sure in editor that there exists CharacterBody2D top level node
	actor = owner as CharacterBody2D
	assert(actor != null)
