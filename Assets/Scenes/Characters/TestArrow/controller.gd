extends CharacterBody2D

const SPEED = 100.0
const FRICTION = 1000.0
var HEALTH = 3.0
var DEBUG = true

func _physics_process(delta):

	var direction = Input.get_vector("left", "right", "up", "down")
	var dirX = 0
	var dirY = 0
	if DEBUG:
		dirX = Input.get_axis("left", "right")
		dirY = Input.get_axis("up", "down")
		$RichTextLabel.text = "[center]" + str(Vector2(dirX, dirY)) + "[/center]"
	if direction:
		velocity = velocity.move_toward(direction * SPEED, FRICTION * delta)

		# animation shit
		match Vector2(dirX, dirY):
			Vector2(0, 1):
				$AnimatedSprite2D.play("S")
			Vector2(1, 1):
				$AnimatedSprite2D.play("SE")
			Vector2(1, 0):
				$AnimatedSprite2D.play("E")
			Vector2(1, -1):
				$AnimatedSprite2D.play("NE")
			Vector2(0, -1):
				$AnimatedSprite2D.play("N")
			Vector2(-1, -1):
				$AnimatedSprite2D.play("NW")
			Vector2(-1, 0):
				$AnimatedSprite2D.play("W")
			Vector2(-1, 1):
				$AnimatedSprite2D.play("SW")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	# move at the end of the frame
	move_and_slide()