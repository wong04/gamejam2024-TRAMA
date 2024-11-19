extends CharacterBody2D

const speed = 110
const accel = 50
const friction = 20
const wallJumpX = 10
var wallSlideGravity = 10.0
const max_fall_speed = 300
const dashmultiplier = 400
const super_jump_height = -350

@onready var emotetimer: Timer = $emotetimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var abilitytimer: Timer = $abilitytimer
@onready var emoteaudio: AudioStreamPlayer = $emoteaudio
@onready var swaptimer: Timer = $swaptimer

var gravity = 900
var jumpVelocity = -250.0
var isOnCooldown = false
var isWallSliding = false
var ableToClimb = false
var selectedAbility = Global.abilities[Global.currentPlayer][Global.Ability[Global.currentPlayer]]
var gravityFlipped = false
var players = ["knight","ogre"]
var isSwapping = false
var isEmoting = false

func _physics_process(delta: float) -> void:
	var inputDir: Vector2 = get_input_direction()
	
	if inputDir.x>0.0:
		animated_sprite.flip_h = false
	elif inputDir.x<0.0:
		animated_sprite.flip_h = true
		
	if !is_on_floor() or !is_on_wall_only():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or is_on_ceiling():
			velocity.y = jumpVelocity
	
	if is_on_floor() or is_on_ceiling() and !is_on_wall():
		if !isSwapping and !isEmoting:
			if inputDir.x == 0.0:
				animated_sprite.play(players[Global.currentPlayer]+"idle")
			else:
				animated_sprite.play(players[Global.currentPlayer]+"run")
	else:
		if !isSwapping and !isEmoting:
			animated_sprite.play(players[Global.currentPlayer]+"jump")

	if is_on_wall_only():
		isWallSliding = true
		velocity.y = wallSlideGravity
		animated_sprite.play(players[Global.currentPlayer] + "wallslide")
	else:
		isWallSliding = false
		
	
	if Input.is_action_just_pressed("emote") and !is_on_wall():
		isEmoting=true
		
		if Global.currentPlayer==0:
			animated_sprite.play("knightemote")
		else:
			animated_sprite.play("ogreemote")
		emoteaudio.play()
		emotetimer.start()
			
	if !isEmoting:
		if Input.is_action_just_pressed("swap") and !is_on_wall():
			if Global.currentPlayer==0:
				animated_sprite.play("knighttoogre")
				print("knigthtooget")
			else:
				animated_sprite.play("ogretoknight")
				print("ogretokinght")
			isSwapping=true
			swaptimer.start()
			
			print("swappressed")
		
		
	if Input.is_action_just_pressed("special") and not isOnCooldown:
		abilitytimer.start()
		isOnCooldown = true

		match selectedAbility:
			"dash":
				accelerate(inputDir * dashmultiplier, delta)
				animated_sprite.play("knightdash")
				print('Dash Activated')
			"superjump":
				if is_on_floor():
					if gravityFlipped==false:
						velocity.y = super_jump_height
					else:
						velocity.y = -super_jump_height
				animated_sprite.play("ogresuperjump")
				print('Super Jumped')
			"walljump":
				if is_on_wall_only():
					velocity.y = jumpVelocity
					if Input.is_action_pressed("move_right"):
						velocity.x = -wallJumpX
					elif Input.is_action_pressed("move_left"):
						velocity.x = wallJumpX
					else:
						if animated_sprite.flip_h:
							velocity.x = wallJumpX
						else:
							velocity.x = -wallJumpX
					animated_sprite.play(players[Global.currentPlayer] + "walljump")
					print("Wall jump triggered!")
			"gravity":
				if is_on_floor() or is_on_ceiling():
					gravityFlipped = not gravityFlipped
					wallSlideGravity = -1* wallSlideGravity
					gravity *= -1
					jumpVelocity *= -1
					animated_sprite.flip_v = not animated_sprite.flip_v
					print('Gravity Flipped')

	# Move the character horizontally
	if inputDir != Vector2.ZERO:
		accelerate(inputDir, delta)

	else:
		if is_on_floor() or is_on_ceiling() and !is_on_wall():
			add_friction(delta)

	# Restart game if needed
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
	playerMovement()

func get_input_direction() -> Vector2:
	var inputDir = Vector2.ZERO
	inputDir.x = Input.get_axis("move_left", "move_right")
	return inputDir.normalized()

func accelerate(direction: Vector2, delta: float) -> void:
	velocity.x = lerp(velocity.x, speed * direction.x, accel * delta)
		
func add_friction(delta: float) -> void:
	velocity.x = lerp(velocity.x, 0.0, friction * delta)

func playerMovement() -> void:
	move_and_slide()
	
func get_angle(dir: Vector2) -> int:
	match dir:
		Vector2(1, 0):
			return 0
		Vector2(0 ,1):
			return 90
		Vector2(1 ,1):
			return 45
	return -1 # Vector2(0, 0)

func _on_timer_timeout() -> void:
	isOnCooldown=false

func _on_swaptimer_timeout() -> void:
	#print("timerup")
	if Global.currentPlayer==0:
		Global.currentPlayer+=1
		selectedAbility = Global.abilities[Global.currentPlayer][Global.Ability[Global.currentPlayer]]
	else:
		Global.currentPlayer-=1
		selectedAbility = Global.abilities[Global.currentPlayer][Global.Ability[Global.currentPlayer]]
	print("Swapped to ability:", selectedAbility)
	isSwapping = false

func _on_emotetimer_timeout() -> void:
	isEmoting=false
	emoteaudio.stop()
