extends Control
@onready var v_box: VBoxContainer = $VBoxContainer
@onready var titleMusic: AudioStreamPlayer = $AudioStreamPlayer

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/selection.tscn")
	Global.scene_play_count += 1

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/controls.tscn") # Replace with function body.

func _ready():
	var current_scene = get_tree().current_scene.name  # Get the name of the current scene
	MusicManager.manage_music(current_scene)
	titleMusic.play()
	
