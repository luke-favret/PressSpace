extends Node

const UP = Vector2(0, -1)
onready var playerNode = get_node("Player")
onready var parallaxBG = get_node("ParallaxSimulation")
onready var hitSound = get_node("hitSound")
onready var bonusSound = get_node("bonusSound")
onready var score = 0
onready var playerHealth = 100
onready var prevPlayerHealth = 100
onready var loopDone = true

var playerMotion = Vector2()
var playerPosSim = Vector2(0,0)
var playerHit = false
var playerBonus = false
#onready var counter = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if(playerHit):
		hitSound.play(0)
		playerHit = false
	if(playerBonus):
		bonusSound.play(0)
		playerBonus = 0
		pass
	#prevPlayerHealth = playerHealth
	if(playerHealth <= 0):
		playerHealth = max(0, playerHealth)
		playerMotion = Vector2(0,0)
		get_node("healthText").set_text(str("Health: ", playerHealth))
		#parallaxBG.scroll_offset = -(playerPosSim/30000)
		#parallaxBG.scroll_offset = parallaxBG.scroll_offset
		get_node("dead").percent_visible = get_node("dead").percent_visible + 1
		#playerPosSim = playerMotion
		#while(counter < 4):
		#OS.delay_usec(1)
		#if(loopDone == true):
			#loopDone = false
		var t = Timer.new()
		t.set_wait_time(5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		print("REEEEEEEEEEEEEEEEEEEEEEEEEEEEE")
		
		#counter += 1
			#loopDone = true
			
		get_tree().change_scene("res://intro.tscn")
	else:
		playerMotion = playerNode.motion
		#print(playerMotion)
		playerPosSim += playerMotion
		
		parallaxBG.scroll_offset = -(playerPosSim/300) #(playerMotion * 20)
		score += int((playerMotion.x + playerMotion.y) * 0.01) 
		get_node("scoreText").set_text(str("Score: ", score))
		get_node("healthText").set_text(str("Health: ", playerHealth))
	pass




var enemyScene = load("res://Enemy.tscn")
func spawnSideways(var sceneIn, var spawnName):
	var rX = rand_range(1000,5000)
	var rY = rand_range(0,800)
	var xSpawnPos = get_node("Player").position.x + rX
	var ySpawnPos = get_node("Player").position.y + rY
	#print(r)
	var e = sceneIn.instance()
	e.set_name(spawnName)
	var spawnPosition = Vector2(xSpawnPos,ySpawnPos)
	#spawnPosition += get_node("Player").position
	#print(spawnPosition)
	#spawnPosition.xSpawnPos += r
	#spawnPosition.ySpawnPos += r
	e.translate(spawnPosition)
	
	add_child(e)
	#print(spawnName, "Spawned")
	pass

func spawnBelow(var sceneIn, var spawnName):
	var rX = rand_range(0,1000)
	var rY = rand_range(800,1500)
	var xSpawnPos = get_node("Player").position.x + rX
	var ySpawnPos = get_node("Player").position.y + rY
	#print(r)
	var e = sceneIn.instance()
	e.set_name(spawnName)
	var spawnPosition = Vector2(xSpawnPos,ySpawnPos)
	#spawnPosition += get_node("Player").position
	#print(spawnPosition)
	#spawnPosition.xSpawnPos += r
	#spawnPosition.ySpawnPos += r
	e.translate(spawnPosition)
	
	add_child(e)
	#print(spawnName, "Spawned")
	pass

func _on_spawnEnemyTimer_timeout():
	
	spawnSideways(enemyScene, "enemy")
	spawnBelow(enemyScene, "enemy")
#	var rX = rand_range(1000,5000)
#	var rY = rand_range(0,1000)
#	var xSpawnPos = get_node("Player").position.x + rX
#	var ySpawnPos = get_node("Player").position.y + rY
#	#print(r)
#	var e = enemyScene.instance()
#	e.set_name("enemy")
#	var spawnPosition = Vector2(xSpawnPos,ySpawnPos)
#	#spawnPosition += get_node("Player").position
#	print(spawnPosition)
#	#spawnPosition.xSpawnPos += r
#	#spawnPosition.ySpawnPos += r
#	e.translate(spawnPosition)
#
#	add_child(e)
	#print("Enemy Spawned")
	pass # Replace with function body.

var bonusScene = load("res://Bonus.tscn")
func _on_spawnBonusTimer_timeout():
	spawnSideways(bonusScene, "bonus")
	spawnBelow(bonusScene, "bonus")
	#print("bonus spawn call")
	pass # Replace with function body.
