extends Node3D

@onready var npcSpawner = preload("res://npc_spawner.tscn")
@export var player = preload("res://player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var spawner = npcSpawner.instantiate()

	add_child(spawner)
	pass # Replace with function body.
