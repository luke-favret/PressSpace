extends KinematicBody2D

const UP = Vector2(0, -1)
# Declare member variables here. Examples:
# var a = 2
# testtt
onready var parentNode = get_parent()
onready var timeAlive = 0
var enemyMotion = Vector2()

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
			parentNode.playerBonus = true
			if(parentNode.playerHealth < 100):
			#print("playercoll")
				parentNode.playerHealth = min(parentNode.playerHealth + 10, 100)
			
				queue_free()
			else:
				parentNode.score += int(parentNode.score * 0.3)
				queue_free()

	pass
