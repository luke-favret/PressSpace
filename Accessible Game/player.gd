extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 15
const XSPEED = 15
const JUMP_HEIGHT = 0
const MAXSPEED = 1500


#var airResistance = 10
var maxSpeedY = 30
var maxSpeedX = 30
var rotateResist = 0.8
var degreesRotated = 15
var xDrag = 1
var totalSpeed
var maxDownSpeed = 0
var horizontalAngle
var verticalAngle

var velocityY = 800
var accelerationY = 0
var velocityModX = 1
var dragX
var dragY
#var rotateresistUp
var minDownSpeed = 1000
var motion = Vector2()   #motion.x and motion.y

var timeCount = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	###############################################################################################################
	rotation_degrees = degreesRotated
	maxSpeedX = MAXSPEED * cos(deg2rad(degreesRotated)) 
	maxSpeedY = MAXSPEED * sin(deg2rad(degreesRotated))
	
	
	#airResistance = 10 - (degreesRotated * degreesRotated)/100
	#if airResistance < 0:
		#airResistance = 0
		
	#maxSpeedY = (GRAVITY - airResistance) * 30
	#motion.y += GRAVITY
	#if motion.y > maxSpeedY:
		#motion.y = maxSpeedY
		
	
		
	#rotateResist = 0.5 * log(degreesRotated)   #pow(1.05, degreesRotated)    #(0.001  * rotation_degrees * rotation_degrees +1)
	
		
	if Input.is_action_pressed("ui_singleInput"):
		
		
		rotateResist = log((degreesRotated * degreesRotated * degreesRotated))
		#print(rotateResist)
		#if rotateResist > 1.5:
			#rotateResist = 1.5
		
		degreesRotated += 3000/(rotateResist * rotateResist * rotateResist)
		if degreesRotated > 85.0:
			degreesRotated = 85.0
		
		timeCount = 0
	
	else:
		#motion.x = 0
		timeCount += 1
		
		if degreesRotated > 2 and timeCount > 10:
			degreesRotated -=  5000/(rotateResist * rotateResist * rotateResist)
			if degreesRotated <= 10:
				degreesRotated = 10
				rotateResist = 0.8
				
	#maxSpeedX = (45 - abs(45 - degreesRotated) ) * 9
	#xDrag = 0.01 + (0.1 - maxSpeedX/900)
	#print(maxSpeedX)
	#if Input.is_action_pressed("ui_left"):
	#motion.x = maxSpeedX
	##velocityX += -(accelerationY * 2) - dragX/1.2 #* (30/(dragX * dragX) )
	#velocityX = log(totalSpeed)/10000 * rotation_degrees - dragX
	##maxDownSpeed -= maxDownSpeed/pow(rotation_degrees,2)
	velocityModX =  maxDownSpeed/2
	maxDownSpeed = lerp(maxDownSpeed, 0, 0.001)
	maxSpeedX += velocityModX
	
	
	motion.x = pow(lerp(sqrt(motion.x), sqrt(maxSpeedX), 0.05),2)
	dragX = pow(motion.x, 2)/(10 * maxSpeedX)
	motion.x -= dragX 
	if motion.x > maxSpeedX:
		motion.x = maxSpeedX
	###############################################################################################################
		
	if is_on_floor():
		motion.y = 0
	horizontalAngle = (1/((90-degreesRotated)))
	verticalAngle = (1/(degreesRotated * 0.1))
	
#	#velocityY = motion.y
##
#	dragX = (( pow(velocityX, 4))/500)
#	dragY =  (( velocityY * velocityY * 0.0003)) * verticalAngle
##	#print(dragY)
#	totalSpeed = sqrt(motion.y * motion.y + motion.x )
##	#motion.Y = totalSpeed
##
##	accelerationY = GRAVITY - dragY
#	velocityY += (accelerationY/2)
	if motion.y > maxDownSpeed:
		maxDownSpeed = motion.y
##
#	if velocityY < minDownSpeed:
#		minDownSpeed = velocityY
#	#print(accelerationY)
#	#print(dragY, "drag")
##	#xVelocity = velocity * lift - dragX
#	motion.y = velocityY

	motion.y = pow(lerp(sqrt(motion.y), sqrt(maxSpeedY), 0.05),2)
	if Input.is_action_pressed("ui_up"):
		motion.y = JUMP_HEIGHT
		motion.x = 0
	if Input.is_action_pressed("ui_down"):
		position.x = 0
		position.y = 0
	 
	#motion = move_and_slide(motion, UP)
	pass 


