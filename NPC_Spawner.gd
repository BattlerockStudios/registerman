extends Node

var cowboy_scene = preload("res://npc_cowboy.tscn")
var woman_scene = preload("res://npc_woman.tscn")

@onready var spawnLocations = [$SpawnPath1/SpawnLocation, $SpawnPath2/SpawnLocation, $SpawnPath3/SpawnLocation, $SpawnPath4/SpawnLocation]

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_spawn_npc(0, cowboy_scene)
	_on_spawn_npc(1, woman_scene)
	pass

func _on_spawn_npc(index: int, resource: Resource) -> void:
	print("Spawn NPC")

	# Create a new instance of the NPC scene.
	var npc = resource.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var npc_spawn_location = spawnLocations[index]
	
	# And give it a random offset.
	npc_spawn_location.progress_ratio = 0

	# var player_position = $Player.position

	npc.position = npc_spawn_location.position;
	# npc.initialize(npc_spawn_location.position, Vector3.ZERO)

	# Spawn the npc by adding it to the Main scene.
	npc_spawn_location.add_child(npc)