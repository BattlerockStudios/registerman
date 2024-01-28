extends Node

@onready var spawnLocations = [
	$SpawnPath1/SpawnLocation,
	$SpawnPath2/SpawnLocation,
	$SpawnPath3/SpawnLocation,
	$SpawnPath4/SpawnLocation,
	$SpawnPath5/SpawnLocation
]

@onready var cowboy = preload("res://npc_cowboy.tscn")
@onready var woman = preload("res://npc_woman.tscn")
@onready var boy = preload("res://npc_boy.tscn")
@onready var dough = preload("res://npc_dough.tscn")
@onready var banana = preload("res://npc_banana.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_spawn_npc(0, cowboy)
	_on_spawn_npc(1, woman)
	_on_spawn_npc(2, boy)
	_on_spawn_npc(3, dough)
	_on_spawn_npc(4, banana)
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

	npc._set_follow_point(npc_spawn_location)

	# Spawn the npc by adding it to the Main scene.
	npc_spawn_location.add_child(npc)
