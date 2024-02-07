extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var num = 200

func _physics_process(delta):

	if !is_on_floor():
		velocity.y += gravity * delta
	elif is_on_floor():
		Global.fall = false
	move_and_slide()
