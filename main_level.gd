extends Node3D

# @onready var npcSpawner = preload("res://npc_spawner.tscn")
@export var player = preload("res://player.tscn")

@onready var checkOutLanePath = $CheckoutLanePath/PathFollow


func _ready():
	pass
