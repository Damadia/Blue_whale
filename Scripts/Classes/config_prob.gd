extends Node
class_name ConfigProb

var WhalesA : int
var WhalesProb : float
var NotWhaleProb : float

func _init(WA: int, WP : float) -> void:
	WhalesA = WA
	WhalesProb = WP
	NotWhaleProb = 1-WP
	
