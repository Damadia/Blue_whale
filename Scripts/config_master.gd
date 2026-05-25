extends Node

@export var AW : LineEdit
@export var PW : LineEdit
@export var NPW : LineEdit

@export var StartButton : Button
@export var FT : TankFish

func _ready() -> void:
	get_tree().paused = true
	self.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
	StartButton.pressed.connect(start_game)
	AW.focus_exited.connect(check_AW)
	PW.focus_exited.connect(check_PW)


func check_AW()->void:
	if !AW_condition():
		AW.clear()
		AW.placeholder_text = "El valor debe ser un número entero mayor a 0"	
	prepare_start()
	
func check_PW()->void:
	if !PW_condition():
		PW.clear()
		PW.placeholder_text = "El valor debe ser un número en el intervalo [0,1]"
	if PW_condition():
		NPW.text = str(1 - float(PW.text))
	
	prepare_start()
	
func AW_condition() -> bool:
	if (!AW.text.is_valid_int()):
		return false
	return AW.text.to_int() > 0
func PW_condition() -> bool:
	if (!PW.text.is_valid_float()):
		return false
	return 0 <= float(PW.text) and float(PW.text) <= 1

func check_settings() -> bool:
	if (!AW_condition()):
		return false
	if (!PW_condition()):
		return false
	return true

func prepare_start() -> void:
	StartButton.disabled = !check_settings()

func start_game()->void:
	var t = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	get_parent().get_node("VBoxContainer").visible = false
	await t.tween_method(set_bg_alpha, 0.58, 0.0, 0.2)
	await t.tween_method(set_font_color, 0.0, 1.0, 3.0)
	get_tree().paused = false
	FT.config = ConfigProb.new(int(AW.text), float(PW.text))

func set_font_color(val : float) -> void:
	var labelsInGame = get_parent().get_parent().get_node("Panel2").get_children()
	for l:Label in labelsInGame:
		l.add_theme_color_override("font_color", Color(0.018,0.018,0.018,val))
		l.add_theme_color_override("font_outline_color", Color(1.0,1.0,1.0,val))
		

func set_bg_alpha(value: float) -> void: 
	var panel : Panel = get_parent()
	var stPanel: StyleBoxFlat = panel.get_theme_stylebox("panel").duplicate()
	stPanel.set_bg_color(Color(0.018,0.018,0.018,value))
	panel.add_theme_stylebox_override("panel", stPanel)
