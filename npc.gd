extends Node3D

var prevPosition: Vector3
var currPosition: Vector3

var startTime: float = 0.1
var timer: float = 0.1

# func _set_follow_point()


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = startTime
	currPosition = global_position
	prevPosition = global_position
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currPosition = global_position

	timer -= delta

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
