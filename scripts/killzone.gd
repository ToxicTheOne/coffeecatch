extends Area3D





func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("obstacles"):
		body.queue_free()
