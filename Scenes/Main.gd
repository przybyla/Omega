extends Node2D

@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface
@onready var journal_interface = $UI/Journal


func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	player.toggle_jourrnal.connect(toggle_journal_interface)
	inventory_interface.set_player_inventory_data(player.inventoryData)


func toggle_inventory_interface() -> void:
	inventory_interface.visible = not inventory_interface.visible
	
func toggle_journal_interface() -> void:
	journal_interface.visible = not journal_interface.visible
	
