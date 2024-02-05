extends Node3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_item_pickup_trigger_body_entered(body: Node3D):
	if body.name == "NPC":
		body._on_pickup_item()
