extends Control
@onready var p1ops: VBoxContainer = $Options/p1options
@onready var p2ops: VBoxContainer = $Options/p2options
@onready var dashrect: ColorRect = $Control/dashrect
@onready var wallrect: ColorRect = $Control/wallrect
@onready var gravrect: ColorRect = $Control/gravrect
@onready var superrect: ColorRect = $Control/superrect
@onready var knight_idle: AnimatedSprite2D = $"Knight Idle"
@onready var ogre_idle: AnimatedSprite2D = $"Ogre Idle"
@onready var level_tracker: Label = $Text/Level

const file_begin = "res://scenes/levels/level"

func _ready():
	if Global.Ability[0]==0:
		dashrect.visible=true
		wallrect.visible=false
	else:
		dashrect.visible=false
		wallrect.visible=true
	if Global.Ability[1]==0:
		superrect.visible=true
		gravrect.visible=false
	else:
		superrect.visible=false
		gravrect.visible=true
	knight_idle.play()
	ogre_idle.play()
	update_selection_screen()
	var current_scene = get_tree().current_scene.name  # Get the name of the current scene
	MusicManager.manage_music(current_scene)
	Global.scene_play_count += 1
	
	
func _on_wall_jump_pressed() -> void:
	Global.Ability[0]=1
	wallrect.visible=true
	dashrect.visible=false
	print("walljump selected")
	
func _on_gravity_flip_pressed() -> void:
	gravrect.visible=true
	superrect.visible=false
	Global.Ability[1]=1
	print("gravityflip selected")
	
func _on_confirm_pressed() -> void:
	var next_level_path = file_begin+str(Global.next_level_number)+".tscn"
	get_tree().change_scene_to_file(next_level_path)

func _on_dash_pressed() -> void:
	dashrect.visible=true
	wallrect.visible=false
	Global.Ability[0]=0
	print("dash selected")

func _on_super_jump_pressed() -> void:
	superrect.visible=true
	gravrect.visible=false
	Global.Ability[1]=0
	print("superjump selected")
	
func update_selection_screen():
	level_tracker.text = "Level: " + str(Global.next_level_number)
