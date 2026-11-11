extends RayCast3D
@export var damage: int = 25

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shoot()

func shoot() -> void:
	print("Bang!")

	force_raycast_update()

	if is_colliding():
		var target = get_collider()

		if target.has_method("take_damage"):
			target.take_damage(damage)
			print("Mob hit!")
		else:
			print("Hit something else: ", target)
	else:
		print("Miss!")
