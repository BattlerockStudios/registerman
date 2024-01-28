extends Node

var cowboy = preload("res://npc_cowboy.tscn")
var woman = preload("res://npc_woman.tscn")

@onready var spawnLocations = [$SpawnPath1/SpawnLocation, $SpawnPath2/SpawnLocation]


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_spawn_npc(0, cowboy)
	# _on_spawn_npc(1, woman)
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

	# var npcScript = npc.get_script()
	# print(npcScript.pathFollowMarker)

	# if npcScript:
	# 	npcScript.pathFollowMarker = npc_spawn_location

	# Spawn the npc by adding it to the Main scene.
	npc_spawn_location.add_child(npc)
