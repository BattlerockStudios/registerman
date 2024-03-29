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

var isTalking: bool = false

@export var itemHolder: Node3D
@export var held_item: Node

@export var npc_name: String
@export var audio: Array[AudioStream]

@onready var item = preload("res://item.tscn")
var isHoldingItem = false

var curr_audio = 0
var rng: RandomNumberGenerator
var min_wander_val = 10
var max_wander_val = 12
var min_chill_val = 5
var max_chill_val = 10


func _set_follow_point(followPath):
	path = followPath


# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	itemHolder = $HeldItem
	timer = startTime
	currPosition = global_position
	prevPosition = global_position
	wanderTime = rng.randf_range(min_wander_val, max_wander_val)
	chillTime = rng.randf_range(min_chill_val, max_chill_val)
	isTalking = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# checks if the player is talking. This logic should be set on a trigger but I'm a lion and I eat monkies. 
	if $AudioStreamPlayer3D.playing == true && isTalking == false:
		isTalking = true
	elif $AudioStreamPlayer3D.playing == false && isTalking == true:
		isTalking = false
	
	currPosition = global_position

	timer -= delta

	if wanderTime > 0:
		wanderTime -= delta
		if path.progress_ratio < completed:
			path.progress_ratio += delta * .05
	else:
		chillTime -= delta
		if chillTime <= 0:
			wanderTime = rng.randf_range(min_wander_val, max_wander_val)
			chillTime = rng.randf_range(min_chill_val, max_chill_val)

	if timer <= 0:
		if currPosition != prevPosition:
			var direction = currPosition - prevPosition
			var absDir = abs(direction)

			if direction.x > 0 && absDir.x > absDir.z:
				if isTalking:
					$AnimatedSprite3D.animation = "walk_sideways_talking"
				else:
					$AnimatedSprite3D.animation = "walk_sideways"
				
				$AnimatedSprite3D.flip_h = false
			elif direction.x < 0 && absDir.x > absDir.z:
				if isTalking:
					$AnimatedSprite3D.animation = "walk_sideways_talking"
				else:
					$AnimatedSprite3D.animation = "walk_sideways"
					
				$AnimatedSprite3D.flip_h = true
			elif direction.z > 0 && absDir.z > absDir.x:
				if isTalking:
					$AnimatedSprite3D.animation = "walk_forward_talking"
				else:
					$AnimatedSprite3D.animation = "walk_forward"
			elif direction.z < 0 && absDir.z > absDir.x:
				$AnimatedSprite3D.animation = "walk_away"
			else:
				if isTalking:
					$AnimatedSprite3D.animation = "idle_talking"
				else:
					$AnimatedSprite3D.animation = "idle"

			prevPosition = currPosition
			timer = startTime

		else:
			if isTalking:
				$AnimatedSprite3D.animation = "idle_talking"
			else:
				$AnimatedSprite3D.animation = "idle"


func _on_audio_timer_timeout():
	$AudioStreamPlayer3D.stop()
	$AudioStreamPlayer3D.stream = audio[curr_audio]
	$AudioStreamPlayer3D.play()

	if curr_audio < len(audio) - 1:
		curr_audio += 1
	else:
		curr_audio = 0
	$AudioTimer.set_wait_time(rng.randf_range(6.0, 20.0))


func _on_pickup_item():
	if isHoldingItem:
		return
	held_item = item.instantiate()
	held_item.freeze = true
	itemHolder.add_child(held_item)
	isHoldingItem = true


func _on_dropoff_item():
	if !isHoldingItem:
		return
	held_item.freeze = false
	itemHolder.remove_child(held_item)
	isHoldingItem = false
