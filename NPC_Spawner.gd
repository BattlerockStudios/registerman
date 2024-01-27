extends Node

var npc_scene = preload("res://npc.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_spawn_npc()
	pass # Replace with function body.

func _on_spawn_npc() -> void:
	print("Spawn NPC")
	# Create a new instance of the NPC scene.
	var npc = npc_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var npc_spawn_location = $SpawnPath/SpawnLocation
	
	# And give it a random offset.
	npc_spawn_location.progress_ratio = randf()

	# var player_position = $Player.position

	npc.position = npc_spawn_location.position;
	# npc.initialize(npc_spawn_location.position, Vector3.ZERO)

	# Spawn the npc by adding it to the Main scene.
	add_child(npc)
