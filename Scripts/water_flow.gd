extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var down = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!down):
		if (self.offset.y > 40.0):
			down = !down
			pass
		self.offset += Vector2(1,0.5)
	if (down):
		if (self.offset.y < -40.0):
			down = !down
			pass
		self.offset += Vector2(1,-0.5)
		
	
	
