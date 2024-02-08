extends Node

@export var claw_machine: Node2D

var rng = RandomNumberGenerator.new()
var rand
var time
var gift
var fall: bool = false
var current_body

func _ready():
	rand = rng.randi_range(3, 7)
	claw_machine.connect("set_body", set_body)
func spawn():
	for i in range(rand):
		var new_gift = preload("res://gift.tscn")
		gift = new_gift.instantiate()
		gift.global_position.x = 150 * (i + 1)
		gift.global_position.y = 500
		gift.add_to_group("gift")
		add_child(gift)
		
func _physics_process(delta):
	if fall:
		if Global.body.is_on_floor():
			fall = false
	elif Global.has_gift:
		if $FallTimer.is_stopped():
			time = rng.randf_range(0.25,2)
			$FallTimer.start(time)
	
		current_body.global_position = $"../ClawMachine/ConnectPoint".global_position

func _on_fall_timer_timeout():
	fall = true
	print(time)
	if time >= 1.7:
		get_tree().change_scene_to_file("res://win_menu.tscn")

func set_body(body):
	
	current_body = body
	print(current_body)
