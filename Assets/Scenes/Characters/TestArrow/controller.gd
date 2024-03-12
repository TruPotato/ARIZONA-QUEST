extends CharacterBody2D

const SPEED = 150.0
const FRICTION = 850.0
var HEALTH = 3.0
var DEBUG = true

func _physics_process(delta):

	var direction = Input.get_vector("left", "right", "up", "down")
	if DEBUG:
		var dirX = Input.get_axis("left", "right")
		var dirY = Input.get_axis("up", "down")
		$RichTextLabel.text = "[center]" + str(Vector2(dirX, dirY)) + "[/center]"
	if direction:
		velocity = velocity.move_toward(direction * SPEED, FRICTION * delta)

		# animation shit
		var animX = Input.get_axis("left", "right")
		var animY = Input.get_axis("up", "down")
		$Character/AnimationTree.set("parameters/Directions/blend_position", Vector2(animX, animY))
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	# move at the end of the frame
	move_and_slide()
