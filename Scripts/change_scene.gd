extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.has_signal("pressed"):
		self.pressed.connect(_on_pressed)
	else:
		printerr("This isn't a button")


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Fishing_game.tscn")
