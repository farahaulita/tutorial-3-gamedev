extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text

export (int) var speed = 400
export (int) var dash_speed = 800
export (int) var crouch_speed = 200
export (int) var jump_speed = -600
var crouch = 0
var double_jump = 0
var dash = 0
var velocity = Vector2()
export (int) var GRAVITY = 1200


const UP = Vector2(0,-1)

func get_input():
	velocity.x = 0
	# Jump
	if is_on_floor() and Input.is_action_just_pressed('ui_up') and !crouch:
		double_jump = 0
		velocity.y = jump_speed
	
	# Double Jump
	if !is_on_floor() and Input.is_action_just_pressed('ui_up') :
		if !double_jump:
			double_jump = 1
			velocity.y = jump_speed
	
	# Crouch, not finished need transform	
	if is_on_floor() and Input.is_action_just_pressed("ui_down"):
		if crouch:
			crouch = 0
			scale = Vector2 (1,1)
		else:
			crouch = 1
			scale = Vector2 (0.8,1)
	
	
	# move right		
	if Input.is_action_pressed("ui_right"):
		
		$Sprite.flip_v= false
		if crouch:
			velocity.x += crouch_speed
		elif dash:
			velocity.x += dash_speed
		else:
			velocity.x += speed
			
	
	# move left		
	if Input.is_action_pressed("ui_left"):
		$Sprite.flip_v= true
		if crouch:
			velocity.x -= crouch_speed
		elif dash:
			velocity.x -= dash_speed
		else:
			velocity.x -= speed
	
		
	
	if(Input.is_action_just_pressed("dash")) and !dash:
		dash = 1

	if(Input.is_action_just_released("dash")) and dash:
		dash = 0

		
	

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
