extends Node3D

var currentPos: Vector2
var prevPos: Vector2

var min_rotation_y = -.05
var max_rotation_y = .05


func _process(delta):
	# look_at(screen_point_to_ray(), Vector3.UP)
	currentPos = get_viewport().get_mouse_position()
	rotate_y(-(currentPos.x - prevPos.x) * 0.1 * delta)

	prevPos = currentPos
	pass
