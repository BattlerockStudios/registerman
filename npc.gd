extends CharacterBody3D

# Track if the NPC completed their path
#	If path completed AND NPC has an item then place it on the counter
# Along the path, check to see if an NPC is near a shelf to grab an item

var prevPosition: Vector3
var currPosition: Vector3

var startTime: float = 0.1
var timer: float = 0.1

var completed: float = 1

var path  # This is the path that we'll use to track progress
var wanderTime: float = 0.1  # NPC's can wander for this time
var chillTime: float = 0.1  # How long an NPC should stop and stare

@export var held_item: Node3D

@export var npc_name: String
@export var audio: Array[AudioStream]

@onready var item = preload("res://item.tscn")
@onready var doritos = preload("res://Snacks/Doritos.png")
@onready var gum = preload("res://Snacks/Gum.png")
@onready var lays = preload("res://Snacks/Lays.png")
@onready var paper = preload("res://Snacks/Paper.png")
@onready var tea = preload("res://Snacks/Tea.png")

@onready var item_array = [doritos, gum, lays, paper, tea]

var curr_audio = 0


func _random_number_range(min_value, max_value) -> float:
	var random_float_range = randf() * (max_value - min_value) + min_value

	# print(random_float_range)
	return random_float_range


func _set_follow_point(followPath):
	path = followPath


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = startTime
	currPosition = global_position
	prevPosition = global_position
	wanderTime = _random_number_range(1, 2)
	chillTime = wanderTime


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currPosition = global_position

	timer -= delta
	if wanderTime > 0:
		wanderTime -= delta
	else:
		chillTime -= delta
		if chillTime < 0:
			wanderTime = _random_number_range(1, 2)
			chillTime = wanderTime
		else:
			if path.progress_ratio < completed:
				path.progress_ratio += delta * .05

	if timer <= 0:
		if currPosition != prevPosition:
			var direction = currPosition - prevPosition
			var absDir = abs(direction)

			if direction.x > 0 && absDir.x > absDir.z:
				$AnimatedSprite3D.animation = "walk_sideways"
				$AnimatedSprite3D.flip_h = false
			elif direction.x < 0 && absDir.x > absDir.z:
				$AnimatedSprite3D.animation = "walk_sideways"
				$AnimatedSprite3D.flip_h = true
			elif direction.z > 0 && absDir.z > absDir.x:
				$AnimatedSprite3D.animation = "walk_forward"
			elif direction.z < 0 && absDir.z > absDir.x:
				$AnimatedSprite3D.animation = "walk_away"
			else:
				$AnimatedSprite3D.animation = "idle"

			prevPosition = currPosition
			timer = startTime

		else:
			$AnimatedSprite3D.animation = "idle"


func _on_audio_timer_timeout():
	$AudioStreamPlayer3D.stop()
	$AudioStreamPlayer3D.stream = audio[curr_audio]
	$AudioStreamPlayer3D.play()

	var rng = RandomNumberGenerator.new()

	if curr_audio < len(audio) - 1:
		curr_audio += 1
	else:
		curr_audio = 0
	$AudioTimer.set_wait_time(rng.randf_range(6.0, 20.0))


func _on_pickup_item():
	if held_item:
		return
	var itm = item.instantiate()
	var randIndex = _random_number_range(0, len(item_array))
	itm.get_node("Sprite3D").texture = item_array[randIndex]
	held_item = itm
	print(held_item)
