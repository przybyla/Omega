extends Resource
class_name SlotData

const MAX_STACK_SIZE: int = 99

@export var item_data: ItemData
@export_range(1, MAX_STACK_SIZE) var quantity: int = 1: set = set_quantity

func can_fully_merge_with(other_slot_data: SlotData) -> bool:
	return item_data == other_slot_data.item_data \
		and item_data.stackable \
		and quantity + other_slot_data.quantity < MAX_STACK_SIZE
	
func fully_merge_with(other_slot_data: SlotData) -> void:
	quantity += other_slot_data.quantity

func set_quantity(val: int) -> void:
	quantity = val
	if quantity > 1 and not item_data.stackable:
		quantity = 1
	
