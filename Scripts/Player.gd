extends CharacterBody2D

@onready var global = Global
@onready var axis = Vector2.ZERO

func _physics_process(delta):
	move(delta)

##Function that get direction player is moving
func get_input_axis():
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

##Function that calculates and apply friction
func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() + amount
	else:
		velocity = Vector2.ZERO

##Function that calculates and apply acelleration
func apply_movement(accel):
	velocity+=accel
	velocity = velocity.limit_length(global.PLAYER_MOVE_SPEED)

##Function that calculates total movement	
func move(delta): 
	axis = get_input_axis()
	##If player`s not moving apply friction
	if axis == Vector2.ZERO:		
		apply_friction(global.PLAYER_FRICTION + delta)
		
	##If player`s moving apply acelleration	
	else:	
		apply_movement(axis * global.PLAYER_ACCELERATION * delta)
	move_and_slide()
	
