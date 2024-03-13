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
	var animation = "diri"
	velocity.x = 0
	# Jump
	if is_on_floor() and Input.is_action_just_pressed('ui_up') and !crouch:
		animation = "lompat"
		double_jump = 0
		velocity.y = jump_speed
	
	# Double Jump
	if !is_on_floor() and Input.is_action_just_pressed('ui_up') :
		if !double_jump:
			animation = "lompat"
			double_jump = 1
			velocity.y = jump_speed
			
	if !is_on_floor()  :
		animation = "lompat"
		
	if is_on_floor() and crouch  :
		animation = "crouch"
			
	
	# Crouch, not finished need transform	
	if is_on_floor() and Input.is_action_just_pressed("ui_down"):
		if crouch:
			animation = "diri"
			
			crouch = 0
			#$Sprite.scale = Vector2 (1,1)
		else:
			animation = "crouch"
			crouch = 1
			
			#$Sprite.scale = Vector2 (1,0.8)
	
	
	# move right		
	if Input.is_action_pressed("ui_right"):
		
		$Sprite.flip_h= false
		
		
		if crouch:
			velocity.x += crouch_speed
			animation = "crouch"
		elif dash:
			velocity.x += dash_speed
		else:
			animation = "jalan"
			velocity.x += speed
			
			
	
	# move left		
	if Input.is_action_pressed("ui_left"):
		$Sprite.flip_h= true
		
		if crouch:
			animation = "crouch"
			velocity.x -= crouch_speed
		elif dash:
			animation = "crouch"
			velocity.x -= dash_speed
		else:
			animation = "jalan"
			velocity.x -= speed
	
		
	
	if(Input.is_action_just_pressed("dash")) and !dash:
		dash = 1

	if(Input.is_action_just_released("dash")) and dash:
		dash = 0
		
	if $Sprite.animation != animation:
		$Sprite.play(animation)

		
	

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
