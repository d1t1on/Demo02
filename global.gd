extends Node

var level: int = 1

func change_owner(changeNode: Node) -> void:
	var childArray: Array = get_all_child(changeNode)
	for child in childArray:
		child.owner = changeNode

func get_all_child(fatherNode: Node) -> Array:
	var childArray: Array = []
	if fatherNode.get_child_count() == 0:
		return childArray
	for child in fatherNode.get_children():
		if child.get_child_count() > 0:
			childArray.append_array(get_all_child(child))
		childArray.append(child)
	return childArray
