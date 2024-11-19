extends Area2D
@onready var timer: Timer = $Timer
@onready var doorOpen: AnimatedSprite2D = $AnimatedSprite2D
var door_opened = false
const file_begin = "res://scenes/levels/level"

func _ready():
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.frame = 0  # Assuming frame 0 is the closed frame

func _process(delta):
	if Global.keys_collected == true and door_opened==false:
		#print("collected")
		doorOpen.play('newDoor')  # Play the open animation only once
		door_opened=true
	if !Global.keys_collected:
		door_opened=false
		doorOpen.set_frame_and_progress(0,0)


func _on_body_entered(body: Node2D) -> void:
	#print("collided")
	if Global.keys_collected == true:
		timer.start()

	


func _on_timer_timeout() -> void:
	#print("timeup")
	Global.keys_collected = false
	var current_scene_file = get_tree().current_scene.scene_file_path
	
	Global.next_level_number = current_scene_file.to_int()+1
	if Global.next_level_number==6:
		get_tree().change_scene_to_file("res://scenes/credits.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/selection.tscn")
	
	
	
	
	#print(next_level_path)
	
