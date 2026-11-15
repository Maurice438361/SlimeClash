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
	show_slime_message()
	queue_free()

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and not event.echo and event.keycode == KEY_H:
			take_damage(25)


func show_slime_message() -> void:
	var hud = CanvasLayer.new()
	get_tree().current_scene.add_child(hud)

	var slime_label = Label.new()
	hud.add_child(slime_label)

	slime_label.text = "+1 Slime"
	slime_label.position = Vector2(30, 30)
	slime_label.add_theme_font_size_override("font_size", 28)

	var tween = hud.create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(hud.queue_free)
