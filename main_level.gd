extends Node3D

var dropOff


func _ready():
	dropOff = $DropOff
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_item_pickup_trigger_body_entered(body: Node3D):
	if body.name == "NPC":
		body._on_pickup_item()


func _on_item_dropoff_trigger_body_entered(body: Node3D):
	if body.name == "NPC":
		body._on_dropoff_item()
		dropOff.add_child(body.held_item)
