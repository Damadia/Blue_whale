extends Node
class_name TankFish

var config : ConfigProb:
	set(Prob):
		config = Prob
		for i in Prob.WhalesA:
			Whales.append(false)
		progress.text += "Ballenas pescadas111: 0" + "/" + str(Prob.WhalesA)
		
var Whales : Array[bool]

var currentFish : Fish

enum Fishes {Dolphin, Fish1,Fish2,Fish3,Shark,Whale}

@export var IMaster : Node
@export var THF : Timer

var Scales : Dictionary = {
	"Dolphin": preload("res://actors/dolphin.tscn"),
	"Shark": preload("res://actors/shark.tscn"),
	"Fish1": preload("res://actors/fish1.tscn"),
	"Fish2": preload("res://actors/fish2.tscn"),
	"Fish3": preload("res://actors/fish3.tscn")
}

var progress : Label
var numberP : int
func _ready() -> void:
	THF.timeout.connect(remove_fish)
	progress = $"../../UI_settings/Panel2/progress"
	numberP = 0

func spawn_fishes_water() -> void:
	pass
#use show and hide fish here
var whale_scene = preload("res://actors/whale.tscn")

#Just god knows how this crap works
func spawn_fishes(rod_offset_x : float = 742.0) -> void:
	var theta = randf()

	if (theta < config.WhalesProb):#REMENBER DELETE THE -1
		var inst = whale_scene.instantiate()
		var f = Fish.new("Whale")
		var w : Node3D = inst.get_node("CollisionShape2D/SubViewportContainer/SubViewport/"+f.name_fish)
		w.rotate_z(PI/2)
		currentFish = f
		f.position = Vector2(270, 540)
		f.sceneRef = w
		f.sceneRef.scale = Vector3(0.9,0.9,0.9)
		#f.animatedSwin()
		f.add_child(inst)
		add_child(f)
		
		var theta2 = randi_range(0, config.WhalesA-1)
		f.show_fish()
		if (!Whales[theta2]):
			numberP+=1
			progress.text = "Ballenas pescadas: " + str(numberP) + "/" + str(config.WhalesA)
			Whales[theta2] = true
			var t = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
			t.tween_method(f.tag_from_red, 0.0, 1.0, 0.001)
			t.tween_method(f.tag_from_red, 1.0, 0.0, 0.25)
			t.tween_method(f.tag_to_green, 0.0, 1.0, 0.5)
		else:
			var t = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
			t.tween_method(f.tag_to_green, 0.0, 1.0, 0.005)
	else:
		var randFish = randf_range(0, Fishes.size() - 1)
		var randFishName = Fishes.keys()[randFish]
		var inst = Scales[str(randFishName)].instantiate()
		var f = Fish.new(str(randFishName))
		f.add_child(inst)
		var w : Node3D = inst.get_node("CollisionShape2D/SubViewportContainer/SubViewport/"+f.name_fish)
		w.rotate_z(PI/2)
		currentFish = f
		f.position = Vector2(270, 540)
		f.sceneRef = w
		f.sceneRef.scale = Vector3(0.9,0.9,0.9)
		##f.animatedSwin()
		add_child(f)
		
		
	if stop_game():
		$"../../UI_settings/Panel2/endScreen".visible = true
	
	
func destroy_fish() -> void:
	hide_fish_ani()
	THF.start(1.5)
	

func hide_fish_ani() -> void:
	if currentFish:
		currentFish.hide_fish()
		
func remove_fish() -> void:
	if currentFish:
		currentFish.queue_free()

func stop_game() -> bool:
	for w in Whales:
		if !w:
			return false
	return true
