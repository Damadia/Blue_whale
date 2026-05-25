extends CharacterBody2D
class_name Fish

var checked : bool = false
@export var name_fish : String
var animPla : AnimationPlayer
var anim : Animation

var sceneRef : Node3D
# if name = null, get_children[0].name

func _init(name) -> void:
	self.name_fish = name

func animatedSwin()->void:
	sceneRef = get_node("CollisionShape2D/SubViewportContainer/SubViewport/"+name_fish)
	animPla = sceneRef.get_node("AnimationPlayer")
	if animPla:
		print("No null")
		anim = animPla.get_animation("Armature|Swim")
		anim.loop_mode = Animation.LOOP_LINEAR
		animPla.play("Armature|Swim")
	else: 
		print("Null")

func show_fish() -> void:
	if (!sceneRef):
		pass	
	var t : Tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var check = self.get_node("Node2D/Check")
	sceneRef.rotate(Vector3(1,0,0), PI/2)
	if check:
		t.tween_property(check, "position:y", check.position.y - 1000, 0.5)
	t.tween_property(sceneRef,"position:y", position.y-100, 0.5)	
	

# hide_fish = show_fish^-1
func hide_fish() -> void:
	if (!sceneRef):
		pass
	sceneRef.rotate_x(0)
	var t : Tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(sceneRef,"position:y", position.y-1000, 0.6)


func tag_to_green(val : float)->void:
	var pan : Panel = get_node("Node2D/Check")
	if pan:
		var stb : StyleBoxFlat = pan.get_theme_stylebox("panel").duplicate()
		stb.bg_color = Color(0.0,val,0.0)
		pan.add_theme_stylebox_override("panel", stb)
	

func tag_from_red(val:float)->void:
	var pan : Panel = get_node("Node2D/Check")
	if pan:
		var stb : StyleBoxFlat = pan.get_theme_stylebox("panel").duplicate()
		stb.bg_color = Color(val,0.0,0.0)
		pan.add_theme_stylebox_override("panel", stb)
