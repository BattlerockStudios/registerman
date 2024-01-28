extends Node3D

var prevPosition: Vector3
var currPosition: Vector3

var startTime: float = 0.1
var timer: float = 0.1

var completed: float = 1

var npcPath  # This is the path that we'll use to track progress
var randomNumber: float = 0.1
var chillTime: float = 0.1


func _random_number_range() -> float:
	var min_value = 1
	var max_value = 2

	var random_float_range = randf() * (max_value - min_value) + min_value

	# print(random_float_range)
	return random_float_range


func _set_follow_point(followPath):
	npcPath = followPath


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = startTime
	currPosition = global_position
	prevPosition = global_position
	randomNumber = _random_number_range()
	chillTime = randomNumber
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currPosition = global_position

	timer -= delta
	if randomNumber > 0:
		randomNumber -= delta
	else:
		chillTime -= delta
		if chillTime < 0:
			randomNumber = _random_number_range()
			chillTime = randomNumber
		else:
			if npcPath.progress_ratio < completed:
				npcPath.progress_ratio += delta * .05

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
	pass
