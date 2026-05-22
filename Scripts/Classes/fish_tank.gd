extends Node
class_name tank_fish

var BW_amount : int
var Whales : Array[Fish]

var Scales : Dictionary = {
	"BW": [0.99, 1.01],
	"D": [0.85, 1.25],
	"F1": [0.55, 1.005],
	"F2": [0.75, 0.9],
}

func _ready() -> void:
	pass # Replace with function body.


#use show and hide fish here
func spawn_fishes(rod_offset_x : float) -> void:
	pass

func on_catch_fish() -> void:
	pass

func stop_game() ->void:
	Whales.all(func(w:Fish): w.checked)
