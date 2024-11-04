extends KinematicBody2D

export var gravity = 10
export var speed = 300
export var jump_force = -250
export var velocity = Vector2(0,0)
export var can_double_jump = true
export var can_double_run = true


var life = 5


signal morreu
var screen_size


func _process(delta):
	if is_on_ceiling():
		velocity.y = 0
	if not is_on_floor():
		velocity.y += gravity
	if is_on_floor():
		can_double_jump = true
		
	var mov_lado = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = mov_lado*speed
	
	
	
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_force
		
	elif Input.is_action_just_pressed("ui_up") and can_double_jump:
		velocity.y = jump_force
		can_double_jump = false
	
	
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite.flip_h = true
# AJEITAR ISSO QUANDO COLOCAR O TERRENO
	if velocity.y == 0:
		if abs(velocity.x) > 0:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")			
	else:
		$AnimatedSprite.play("jump")
	
	if life <= 0:
		position = Vector2(232,338)
		
	move_and_slide(velocity, Vector2.UP)

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("morreu")


func _on_AreaMorte_morreu():
	position = Vector2(232,338)
	
	


