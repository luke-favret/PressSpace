extends KinematicBody2D
const UP = Vector2(0, -1)
# Declare member variables here. Examples:
# var a = 2
# testtt
onready var parentNode = get_parent()
onready var timeAlive = 0
var enemyMotion = Vector2()
onready var hitSound = get_node("hitSound")

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(timeAlive > 1000):
		queue_free()
	else:
		enemyMotion = -(parentNode.playerMotion)
		enemyMotion = move_and_slide(enemyMotion, UP)
		timeAlive += 1
		
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if(collision.collider.name == "Player"):
			hitSound.play(0)
			#print("playercoll")
			parentNode.playerHealth -= 5
			parentNode.playerHit = true
			queue_free()

	pass
