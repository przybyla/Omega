extends Node

func find_player() -> Player:
	return get_tree().get_first_node_in_group("Player")
