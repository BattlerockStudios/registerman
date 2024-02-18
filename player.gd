extends Node3D

var currentPos: Vector2
var prevPos: Vector2

var min_rotation = -75
var max_rotation = 45
var rotationModifier = 0.5


func _process(_delta):
	currentPos = get_viewport().get_mouse_position()
	var direction = -(currentPos.x - prevPos.x) * rotationModifier
	rotate_y(deg_to_rad(direction))
	var self_rotation = rotation_degrees
	self_rotation.y = clamp(self_rotation.y, min_rotation, max_rotation)
	rotation_degrees = self_rotation
	prevPos = currentPos
