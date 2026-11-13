extends StaticBody3D

@export var max_health: int = 25

var current_health: int

func _ready() -> void:
	current_health = max_health
	print("Mob spawned with ", current_health, " HP")


func take_damage(amount: int) -> void:
	current_health -= amount

	print("Mob HP: ", current_health)

	if current_health <= 0:
		die()


func die() -> void:
	print("Mob died!")
	queue_free()

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and not event.echo and event.keycode == KEY_H:
			take_damage(25)
