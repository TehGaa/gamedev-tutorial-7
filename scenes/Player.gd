extends CharacterBody3D

@export var speed: float = 10.0
@export var sprintSpeed: float = 30.0
@export var acceleration: float = 5.0
@export var gravity: float = 9.8
@export var jump_power: float = 5.0
@export var mouse_sensitivity: float = 0.3

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

@export var crouchHeight: float = 0.5
@export var standingHeight: float = 1.0  

var camera_x_rotation: float = 0.0
var curSpeed: float = 0.0
var isCrouch: bool = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$CollisionShape3D.scale.y = standingHeight
	mesh.scale.y = 1.0
	head.position.y = standingHeight
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation + x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = -camera_x_rotation
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("crouch"):
		toggle_crouch()

func toggle_crouch():
	isCrouch = !isCrouch
	if isCrouch:
		$CollisionShape3D.scale.y = crouchHeight
		mesh.scale.y = crouchHeight / standingHeight
		head.position.y = crouchHeight
	else:
		$CollisionShape3D.scale.y = standingHeight
		mesh.scale.y = 1.0
		head.position.y = standingHeight
	
func _physics_process(delta):
	curSpeed = speed
	var movement_vector = Vector3.ZERO
	
	if Input.is_action_pressed("sprint"):
		curSpeed = sprintSpeed

	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head.basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head.basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head.basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head.basis.x

	movement_vector = movement_vector.normalized()

	velocity.x = lerp(velocity.x, movement_vector.x * curSpeed, acceleration * delta)
	velocity.z = lerp(velocity.z, movement_vector.z * curSpeed, acceleration * delta)

	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power

	move_and_slide()
