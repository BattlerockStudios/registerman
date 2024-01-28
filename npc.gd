extends Node3D

@onready var spawner = $NPC_Spawner


# Called when the node enters the scene tree for the first time.
func _ready():
	print(spawner)
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if pathFollowMarker:
	# 	pathFollowMarker.progress_ratio += delta * 100
	pass
