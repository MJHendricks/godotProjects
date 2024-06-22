extends CharacterBody2D


@export var SPEED = 100.0

#jump settings
@export var JUMP_VELOCITY = 0.0
var jumpTimer =0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	jump(delta)

	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		
		#velocity.y = JUMP_VELOCITY
		#$AnimationPlayer.play("Jump")		



	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	movement(direction)
	
func movement(direction) :
	if direction > 0:
		$Sprite2D.scale.x = 1;
		velocity.x = direction * SPEED
		if $AnimationPlayer.current_animation == "Idle" or velocity.y == 0:
			$AnimationPlayer.play("Walk")
	
	elif direction < 0:
		$Sprite2D.scale.x = -1;
		velocity.x = direction * SPEED
		if $AnimationPlayer.current_animation == "Idle" or velocity.y == 0:
			$AnimationPlayer.play("Walk")
	
	elif direction == 0:
		velocity.x = 0
		
	if direction == 0 and velocity.y == 0: 
		velocity.x = 0
		$AnimationPlayer.play("Idle")
		
	move_and_slide()
	
func jump(delta) :
	JUMP_VELOCITY = -200.0
	jumpTimer = 0.0
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimationPlayer.play("Jump")		
		
	if Input.is_action_pressed("ui_accept") and velocity.y < 0:
		velocity.y -= 11.0 + delta
		$AnimationPlayer.play("Jump")	
		
	
