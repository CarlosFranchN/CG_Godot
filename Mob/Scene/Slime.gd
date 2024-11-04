extends KinematicBody2D

# Variáveis de movimento
export (int) var speed = 100
export (int) var gravity = 500
export (int) var patrol_distance = 200

# Referências
var velocity = Vector2()
var direction = 1  # Direção inicial (1 para direita, -1 para esquerda)
var start_position = Vector2()

func _ready():
	start_position = position

func _physics_process(delta):
	# Aplica gravidade
	velocity.y += gravity * delta

	# Movimenta o mob horizontalmente
	velocity.x = direction * speed

	# Verifica se o mob chegou ao limite de patrulha
	if abs(position.x - start_position.x) > patrol_distance:
		direction *= -1  # Inverte a direção
	
	# Move o mob
	velocity = move_and_slide(velocity, Vector2.UP)

	# Atualiza animação com base na direção
	if direction > 0:
		$AnimatedSprite.flip_h = false  # Virado para a direita
	else:
		$AnimatedSprite.flip_h = true  # Virado para a esquerda

	# Controla animações (exemplo)
	if is_on_floor():
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("jump")
