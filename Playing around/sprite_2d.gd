extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(0, 400) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += 1
