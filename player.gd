extends CharacterBody2D
class_name Player

signal health_changed

var run_speed = 50
var attacking = false
var health = 5
var alive = true

func _physics_process(delta):
	if not alive:
		return
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input * run_speed
	if attacking:
		velocity = Vector2.ZERO
		return
	move_and_slide()
	# pick which animation
	if velocity.length() > 0:
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")
	# handle flipping direction
	if velocity.x != 0:
		transform.x.x = sign(velocity.x)

func _input(event):
	if event.is_action_pressed("attack"):
		attack()

func attack():
	$AnimationPlayer.play("attack")
	attacking = true
	await $AnimationPlayer.animation_finished
	attacking = false

func _on_hurtbox_body_entered(body):
	body.hurt(1, position.direction_to(body.position))

func hurt(amount, dir):
	health -= amount
	health_changed.emit(health)
	if health <= 0:
		$AnimationPlayer.play("death")
		$CollisionShape2D.set_deferred("disabled", true)
		alive = false
