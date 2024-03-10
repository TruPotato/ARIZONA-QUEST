extends CharacterBody2D

var speed: float = 30.0
var accel: float = 100.0
@onready var player = $"../TestArrow"
#@onready var movement_target_position: Vector2 = player.position

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	pass

func _physics_process(delta):
	var direction = Vector3()
	navigation_agent.target_position = player.position
	direction = navigation_agent.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction*speed, accel*delta)
	
	move_and_slide()
