extends Node

@onready var spawnPoints = [
	{"location": $SpawnPath1/SpawnLocation, "occupied": false},
	{"location": $SpawnPath2/SpawnLocation, "occupied": false},
	{"location": $SpawnPath3/SpawnLocation, "occupied": false},
	{"location": $SpawnPath4/SpawnLocation, "occupied": false},
	{"location": $SpawnPath5/SpawnLocation, "occupied": false},
	{"location": $SpawnPath6/SpawnLocation, "occupied": false}
]

@onready var cowboy = preload("res://npc_cowboy.tscn")
@onready var woman = preload("res://npc_woman.tscn")
@onready var boy = preload("res://npc_boy.tscn")
@onready var dough = preload("res://npc_dough.tscn")
@onready var banana = preload("res://npc_banana.tscn")
@onready var karen = preload("res://npc_karen.tscn")

@onready var npc_array = [
	{"npc": cowboy, "enabled": false},
	{"npc": woman, "enabled": false},
	{"npc": boy, "enabled": false},
	{"npc": dough, "enabled": false},
	{"npc": banana, "enabled": false},
	{"npc": karen, "enabled": false}
]
@onready var timer = $SpawnTimer
@onready var val = 0


func _ready():
	_on_spawn_timer_timeout()


func _on_spawn_npc(index: int, resource: Resource) -> void:
	print("Spawn NPC")

	# Create a new instance of the NPC scene.
	var npc = resource.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var spawnPoint = spawnPoints[index]

	# And give it a random offset.
	spawnPoint.location.progress_ratio = 0

	npc._set_follow_point(spawnPoint.location)

	# Spawn the npc by adding it to the Main scene.
	spawnPoint.location.add_child(npc)
	val += 1


func _on_spawn_timer_timeout():
	var filtered_npc_array = npc_array.filter(remove_disabled)
	if !filtered_npc_array:
		return
	var random_range = randi() % filtered_npc_array.size()
	var available_npcs = filtered_npc_array[random_range]

	var npc = available_npcs.npc
	if val >= npc_array.size():
		val = 0
	_on_spawn_npc(val, npc)
	available_npcs.enabled = true


func remove_disabled(item):
	return !item["enabled"]
