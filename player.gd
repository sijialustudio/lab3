extends CharacterBody2D

@export var speed: int = 200
@export var max_health: int = 3

var health: int = max_health
var respawn_position: Vector2

signal health_changed(health)

func _ready():
	respawn_position = global_position  # Save starting position
	health_changed.emit(health)  # Ensure UI updates at start
	print("Player initialized. Health:", health)  

func _physics_process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1

	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	
func take_damage(amount: int):
	health -= amount
	health_changed.emit(health) 
	print("Player health:", health) 

	if health <= 0:
		respawn_player()
	else:
		flash_sprite()  #blink when taking damage


func respawn_player():
	print("Player died! Respawning...")
	await get_tree().create_timer(1.0).timeout  # delay before respawn
	global_position = respawn_position  # Move player back to last checkpoint
	health = max_health  # Reset health
	health_changed.emit(health)  # Update UI
	print("Respawned. Health reset to:", health)

func flash_sprite():
	var sprite = $Sprite2D
	for i in range(5):
		sprite.visible = false
		await get_tree().create_timer(0.1).timeout
		sprite.visible = true
		await get_tree().create_timer(0.1).timeout
