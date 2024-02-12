extends PanelContainer

@export var slot: PackedScene

@onready var item_grid = $MarginContainer/ItemGrid

func set_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)

func populate_item_grid(inventory_data: InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()
		
	for slot_data in inventory_data.slot_datas:
		var slot_instance = slot.instantiate()
		item_grid.add_child(slot_instance)
		
		slot_instance.slot_clicked.connect(inventory_data.on_slot_clicked)
		
		if slot_data:
			slot_instance.set_slot_data(slot_data)
