extends Node3D

@onready var dialogue_ui = get_tree().current_scene.get_node("dialogue_ui/canvas")
@onready var speaker_name: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/canvas/speaker_name")
@onready var dialogue_text: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/canvas/dialogue_text")
@onready var player: CharacterBody3D = get_tree().current_scene.get_node("player")
@onready var npc_animation: AnimationPlayer = get_tree().current_scene.get_node("npc/visual/mage/AnimationPlayer")

@export var dialogues: Array[String]
@export var speaker_names: Array[String]
@export var speaker: StaticBody3D

@export var is_stash: bool = false
@export var dialogues_after_stash: Array[String]
@export var speaker_names_after_stash: Array[String]

var active_dialogues: Array[String]
var active_speaker_names: Array[String]

var current_dialogue = -1
var started = false

func _ready() -> void:
	dialogue_ui.visible = false
	dialogue_ui.get_node("continue").connect("pressed", Callable(self, "continue_dialogue"))

func start_dialogue(body):
	if body == player and !started:
		started = true
		current_dialogue = -1
		
		if is_stash:
			player.stash_found = true

		if !is_stash and player.stash_found and !dialogues_after_stash.is_empty():
			active_dialogues = dialogues_after_stash
			active_speaker_names = speaker_names_after_stash
		else:
			active_dialogues = dialogues
			active_speaker_names = speaker_names
			
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player.SPEED = 0.0
		player.sensitivity = 0.0
		dialogue_ui.visible = true
		
		speaker.rotation_degrees.x = 0.0
		speaker.rotation_degrees.z = 0.0
		npc_animation.play("Use_Item")
		continue_dialogue()

func end_dialogue():
	current_dialogue = -1
	started = false
	dialogue_ui.visible = false
	player.SPEED = 5.0
	player.sensitivity = 0.003
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	npc_animation.play("Idle_A")

func continue_dialogue():
	if !started:
		return
		
	current_dialogue += 1
	
	if current_dialogue < active_dialogues.size():
		dialogue_text.text = active_dialogues[current_dialogue]
		speaker_name.text = active_speaker_names[current_dialogue]
	else:
		end_dialogue()
