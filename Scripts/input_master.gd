extends Node

enum States {idle, fishing, hook}
var currentState = States.idle
@export var MTW : Timer 
@export var THF : Timer

signal CatchFish
@export var FT : TankFish
@export var FM : StaticBody2D

func _ready() -> void:
	MTW.wait_time = 0.1
	MTW.timeout.connect(on_time_finish)
	currentState = States.fishing
	
func _input(event: InputEvent) -> void:
	if currentState == States.fishing:
		if event.is_action_pressed("Rod"):
			print("AHHHHHHHHHHHHHHHH")
			FT.spawn_fishes()
			change_state(States.hook)
	
	if currentState == States.hook:
		if event.is_action_pressed("To_water"):
			FT.destroy_fish()
			change_state(States.fishing)
			
	if event.is_action_pressed("Restart"):
		get_tree().reload_current_scene()

func change_state(newState : States) -> void:
	exit_state(currentState)
	currentState = newState
func exit_state(state: States) -> void:
	if state == States.fishing:
		var anims : AnimatedSprite2D = FM.get_node("Animations")
		anims.play("Hook")
		await anims.animation_finished 
	if state == States.hook:
		var anims : AnimatedSprite2D = FM.get_node("Animations")
		anims.play_backwards("Hook")
		await anims.animation_finished
		anims.play("Fishing")
		

func on_fish_hide() -> void:
	pass

func on_time_finish() ->void:
	pass
