extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$GiftSpawner.spawn()
	
func _physics_process(delta):
	if Global.has_gift:
		pass
