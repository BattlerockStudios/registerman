extends Node3D

@onready var doritos = preload("res://Snacks/Doritos.png")
@onready var gum = preload("res://Snacks/Gum.png")
@onready var lays = preload("res://Snacks/Lays.png")
@onready var paper = preload("res://Snacks/Paper.png")
@onready var tea = preload("res://Snacks/Tea.png")

@onready var item_array = [doritos, gum, lays, paper, tea]
var rng = RandomNumberGenerator.new()


func _ready():
	var randIndex = rng.randf_range(0, len(item_array))
	$Sprite3D.texture = item_array[randIndex]
