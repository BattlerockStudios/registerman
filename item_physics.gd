extends RigidBody3D

const MOVEMENT_FORCE = 500


func _on_body_entered(body: Node):
	# Check if the body entered is a RigidBody
	if body is RigidBody3D:
		print("test ")
		# Apply an impulse to move the rigidbody
		var direction = (global_transform.origin - body.global_transform.origin).normalized()
		apply_impulse(Vector3.ZERO, direction * MOVEMENT_FORCE)
