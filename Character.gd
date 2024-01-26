extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 20
var gravity = -9.8  # Define gravity
var jump_force = 10 # Define jump force


var velocity = Vector3()  # Move velocity outside of _physics_process

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var move_direction = Vector3()

	if Input.is_action_pressed('ui_up'):
		move_direction -= transform.basis.z
	if Input.is_action_pressed('ui_down'):
		move_direction += transform.basis.z

	if Input.is_action_pressed('ui_left'):
		rotate_y(delta)  # Rotate to the left
	if Input.is_action_pressed('ui_right'):
		rotate_y(-delta)  # Rotate to the right

	move_direction = move_direction.normalized() * speed

	velocity.y += gravity * delta  # Apply gravity to the y-component of velocity

	if Input.is_action_just_pressed('ui_jump') and is_on_floor():  # Jump when 'ui_jump' is pressed and character is on floor
		print("Jumping")
		velocity.y = jump_force

	velocity.x = move_direction.x
	velocity.z = move_direction.z

	velocity = move_and_slide(velocity, Vector3.UP)

	if is_on_floor():  # Reset y-component of velocity when on floor
		velocity.y = 0
	
	
	
