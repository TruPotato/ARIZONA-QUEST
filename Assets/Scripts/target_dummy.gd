extends CharacterBody2D


var health = EnemyStats["testdummy"]["Health"]
var contactDamage = EnemyStats["testdummy"]["Contact Damage"]
@onready var navAgent = $NavigationAgent2D
var SPEED = EnemyStats["testdummy"]["Speed"]
var target: Vector2
@onready var player = $"../TestArrow"
@onready var stoogeArea = $stoogeArea #enemy collisions
var tracking = false
var tempFricMod = 1
var knockedBack = false

func _ready():
	print("Player: ", player)
	target = self.position
	updateTargetPosition(target)


func _process(delta):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(self.position,player.position)
	var result = space_state.intersect_ray(query)
	target = Vector2(player.position)
	updateTargetPosition(target)
	#tracking
	if position.distance_to(target) < 2000 and result.collider == player:
		tracking = true
	#if not on target and tracking and not knocked back
	if position.distance_to(target) > 1 and tracking and !knockedBack:
		var location = global_transform.origin
		var nextLoc = navAgent.get_next_path_position()
		var nextVel = (nextLoc - location).normalized() * SPEED
		nextVel.limit_length(SPEED)
		if velocity.length() > SPEED:
			velocity*=0.9
		else: velocity += nextVel
	else: velocity*=(0.6*tempFricMod)
	if tempFricMod > 1:
		tempFricMod -= 0.01
	else: knockedBack = false
	move_and_slide()
	if health <=0:
		queue_free()


func updateTargetPosition(target):
	navAgent.set_target_position(target)

func _on_stooge_area_body_entered(body):
	var oppositeDir = position.direction_to(body.position)
	if body.is_in_group("enemy") and body != self:
		body.tempFricMod = 1.6
		body.velocity = (oppositeDir * 2500)
