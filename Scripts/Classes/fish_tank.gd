extends Node
class_name TankFish

var config : ConfigProb:
	set(Prob):
		config = Prob
		for i in Prob.WhalesA:
			Whales.append(false)
		print("AW: %s \nPW: %s" % [Prob.WhalesA, Prob.WhalesProb])
var Whales : Array[bool]

var currentFish : Fish

enum Fishes {Dolphin, Fish1,Fish2,Fish3,Shark,Whale}

@export var IMaster : Node
@export var THF : Timer

var Scales : Dictionary = {
	"Whale": [0.99, 1.01],
	"Dolphin": [0.85, 1.25],
	"Shark": [0.95, 1.2],
	"Fish1": [0.55, 1.005],
	"Fish2": [0.65, 0.85],
	"Fish3": [0.325, 0.62]
}


func _ready() -> void:
	THF.timeout.connect(remove_fish)


func spawn_fishes_water() -> void:
	pass
#use show and hide fish here
var fish1_scene = preload("res://actors/fish1.tscn")
var fish2_scene = preload("res://actors/fish2.tscn")
var fish3_scene = preload("res://actors/fish3.tscn")
var shark_scene = preload("res://actors/shark.tscn")
var dolphin_scene = preload("res://actors/dolphin.tscn")
var whale_scene = preload("res://actors/whale.tscn")

func spawn_fishes(rod_offset_x : float = 742.0) -> void:
	var theta = randf()
	if (theta-99 < config.WhalesProb):#REMENBER DELETE THE -1
		var inst = whale_scene.instantiate()
		var f = Fish.new("whale")
		var w : Node3D = inst.get_node("CollisionShape2D/SubViewportContainer/SubViewport/Whale")
		w.rotate_z(PI/2)
		currentFish = f
		f.position = Vector2(rod_offset_x, 555)
		add_child(inst)
		inst.position = Vector2(100,100)
		add_child(f)
		print(get_children())
		print(f.is_inside_tree())
		#f.add_child(inst)
		#f.animatedSwin()
		#var theta2 = randi_range(0, config.whalesA)
		#if (!Whales[theta2]):
			#f.show_fish()
			#Whales[theta2] = true
			#var t = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
			#t.tween_method(f.tag_to_red, 0.0, 1.0, 0.01)
			#t.tween_method(f.tag_to_red, 1.0, 0.0, 0.05)
			#t.tween_method(f.tag_to_green, 0.0, 1.0, 1.5)
			#if stop_game():
				#print("Finish msg")
		#else:
			#var t = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
			#t.tween_method(f.tag_to_green, 0.0, 1.0, 1.5)
			#
	
	
func destroy_fish() -> void:
	hide_fish_ani()
	THF.start(0.8)

func hide_fish_ani() -> void:
	if currentFish:
		currentFish.hide_fish()
func remove_fish() -> void:
	if currentFish:
		currentFish.queue_free()


func on_catch_fish() -> void:
	pass

func stop_game() -> bool:
	return Whales.all(func(w:bool): w)
