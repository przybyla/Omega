extends Node2D

@export var player_scene: PackedScene

@onready var inventory_interface = $UI/InventoryInterface
@onready var journal_interface = $UI/Journal

var utils = Utils
var player: Player

func _ready() -> void:
	# spawn player
	player = spawn_player()
	
	player.toggle_inventory.connect(toggle_inventory_interface)
	player.toggle_jourrnal.connect(toggle_journal_interface)
	inventory_interface.set_player_inventory_data(player.inventoryData)

func spawn_player() -> Player:
	if (player != null):
		player.queue_free()
	
	player_scene.instantiate()
	return utils.find_player()

func toggle_inventory_interface() -> void:
	inventory_interface.visible = not inventory_interface.visible
	
func toggle_journal_interface() -> void:
	journal_interface.visible = not journal_interface.visible
	
