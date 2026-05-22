extends CharacterBody2D
class_name Fish

var checked : bool = false
var p : float 
var name_fish : String
# if name = null, get_children[0].name

func _ready() -> void:
	pass # Replace with function body.

func show_fish() -> void:
	pass

# hide_fish = show_fish^-1
func hide_fish() -> void:
	pass
	
func flip_fish(rect : float , x := true) -> void:
	pass
