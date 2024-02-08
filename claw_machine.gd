extends Node2D

var grab = false
var lift = false
var can_move = true
var has_gift1 = false
var has_gift2 = false
signal set_body

var swingleft = false
var swingright = false
func _input(event):
	if can_move:
		if position.x < 1000:
			if event.is_action_pressed("ui_right"):
				position.x += 25
				swingright = true
		if position.x > 100:
			if event.is_action_pressed("ui_left"):
				position.x -= 25
				swingleft = true
		if !grab:
			if event.is_action_pressed("ui_accept"):
				grab = true
				can_move = false
			
func _physics_process(delta):
	if abs($Claw.rotation_degrees) < 60:
		if swingleft:
			$Claw.rotation_degrees -= 30
			swingleft = false
		if swingright:
			$Claw.rotation_degrees += 30
			swingright= false
	if $Claw.rotation_degrees > 0:
		$Claw.rotation_degrees = lerpf($Claw.rotation_degrees, 0, .2)
	elif $Claw.rotation_degrees < 0:
		$Claw.rotation_degrees = lerpf($Claw.rotation_degrees, 0, .2)
	if grab:
		if position.y < 300:
			position.y += 5
		else:
			grab = false
			$Timer.start()
	if lift:
		if position.y > 0:
			position.y -= 3
		else:
			lift = false
			can_move = true


func _on_timer_timeout():
	lift = true
	if has_gift1 and has_gift2:
		Global.has_gift = true
		has_gift1 = false
		has_gift2 = false
	

func _on_area_2d_body_entered(body):
	if body.is_in_group("gift"):
		has_gift1 = true
		Global.body = body
		emit_signal("set_body", body)

func _on_area_2d_body_exited(body):
	if body.is_in_group("gift"):
		has_gift1 = false
		Global.has_gift = false


func _on_area_2d_2_body_entered(body):
	if body.is_in_group("gift"):
		has_gift2 = true
		Global.body = body


func _on_area_2d_2_body_exited(body):
	if body.is_in_group("gift"):
		has_gift2 = false
		Global.has_gift = false
