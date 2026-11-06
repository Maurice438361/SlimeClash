extends Node3D

@onready var dialogue_ui = get_tree().current_scene.get_node("dialogue_ui/canvas")
@onready var speaker_name: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/canvas/speaker_name")
@onready var dialogue_text: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/canvas/dialogue_text")
@onready var player: CharacterBody3D = get_tree().current_scene.get_node("player")

@export var dialogues: Array[String]
@export var speaker_names: Array[String]
@export var speaker: Node3D

var current_dialogue = -1
var started = false

func _ready() -> void:
	dialogue_ui.get_node("continue").connect("pressed", Callable(self, "continue_dialogue"))

func start_dialogue(body):
	if body == player:
		started = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player.SPEED = 0.0
		player.sensitivity = 0.0
		dialogue_ui.visible = true
		player.look_at(player.global_transform.origin)
		speaker.rotation_degrees.x = 0.0
		speaker.rotation_degrees.z = 0.0

func end_dialogue():
	player.SPEED = 5.0
	player.sensitivity = 0.003
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	dialogue_ui.visible = false

func continue_dialogue():
	current_dialogue += 1
	if current_dialogue < dialogues.size():
		if !dialogue_ui.visible:
			dialogue_ui.visible = true
		dialogue_text.text = dialogues[current_dialogue]
		speaker_name.text = speaker_names[current_dialogue]
	else:
		end_dialogue()
