extends Area2D

@export var activated_texture: Texture
@onready var sprite: Sprite2D = $Sprite2D  # Reference to the sprite

var activated: bool = false

func _on_body_entered(body):
	if body is CharacterBody2D and not activated:
		print("Checkpoint Activated!")
		activated = true
		body.set_respawn_position(global_position)  # Update player's respawn position

		# Change sprite to activated version
		if activated_texture:
			sprite.texture = activated_texture
			sprite.queue_redraw()
		print("Checkpoint sprite updated!")
