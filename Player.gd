extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text

export (int) var speed = 400
export (int) var dash_speed = 600
export (int) var crouch_speed = 200
export (int) var jump_speed = -600
var crouch = 0
var double_jump = 0
var dash = 0
export var double_tap_delay=0.5
export var stop_delay=0.01
var press_count=0
onready var press_timer=$Timer
var velocity = Vector2()
onready var dash_timer = $Timer2
export (int) var GRAVITY = 1200
var dash_time = 1

const UP = Vector2(0,-1)

func _ready():
	press_timer.one_shot=true
	dash_timer.one_shot=true
	press_timer.connect("timeout",self,"set",["press_count",0])
	dash_timer.connect("timeout",self,"set",["dash",0])


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
	
	if(velocity.x):if(Input.is_action_just_pressed("ui_right") ||Input.is_action_just_pressed("ui_left")) and !dash:

		press_count=clamp(press_count+1,0,2)
		press_timer.wait_time=double_tap_delay
		
		
	if press_count==2:
		print("dash")
		press_timer.stop()
		dash = 1
		dash_timer.start()
		
	elif(!press_timer.time_left):
		press_timer.start()
	
	elif(!press_timer.time_left && press_count):
		press_timer.wait_time=stop_delay
		press_timer.start()
		
	

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
	

func _on_dash_timer_cooldown():
	dash=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
