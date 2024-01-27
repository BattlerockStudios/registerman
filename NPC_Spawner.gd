extends Node

var npc_scene = preload("res://npc.tscn")

@onready var spawnLocations = [$SpawnPath1/SpawnLocation, $SpawnPath2/SpawnLocation, $SpawnPath3/SpawnLocation, $SpawnPath4/SpawnLocation]

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_spawn_npc(0)
	pass

func _on_spawn_npc(index: int) -> void:
	print("Spawn NPC")

	# Create a new instance of the NPC scene.
	var npc = npc_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var npc_spawn_location = spawnLocations[index]
	
	# And give it a random offset.
	npc_spawn_location.progress_ratio = randf()

	# var player_position = $Player.position

	npc.position = npc_spawn_location.position;
	# npc.initialize(npc_spawn_location.position, Vector3.ZERO)

	# Spawn the npc by adding it to the Main scene.
	add_child(npc)
