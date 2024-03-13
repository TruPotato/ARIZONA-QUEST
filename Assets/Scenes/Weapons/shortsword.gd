extends Node2D


var attacking = false
var combo = false

func _ready():
	$RichTextLabel.top_level = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	look_at(get_global_mouse_position())

	var anim = $AnimationTree.get("parameters/playback").get_current_node()
	if Input.is_action_just_pressed("attack"):
		if anim != "SwingRight":
			attacking = true
		else:
			combo = true

	$AnimationTree.set("parameters/conditions/swing", attacking)
	$AnimationTree.set("parameters/conditions/combo", combo)

	$RichTextLabel.text = "[center]" + str(anim) + "[/center]\n[center]" + str(attacking) + "[/center]\n[center]" + str(combo) + "[center]"
	attacking = false
	combo = false
